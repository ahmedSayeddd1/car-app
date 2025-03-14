import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());
  var verificationId = ''.obs;
  var isCodeSent = false.obs;
  var userType = 'User'.obs; // 'User' or 'Provider'
  var selectedLanguage = 'en'.obs;

  void changeLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    Get.updateLocale(Locale(languageCode));
  }

  Future<void> phoneNumberVerification() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.offNamed('/HomeView');
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          isCodeSent.value = true;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
        timeout: Duration(seconds: 60),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to send OTP: $e');
      print('================================ ${e}');
    }
  }

  Future<void> verifyOTP() async {
    try {
      String otp = otpControllers.map((controller) => controller.text).join();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      Get.offNamed('/HomeView');
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP: $e');
    }
  }

  Future<void> resendOTP() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.offNamed('/HomeView');
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          isCodeSent.value = true;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
        timeout: Duration(seconds: 60),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend OTP: $e');
    }
  }

  //////////////
  Future<void> handleUserLogin() async {
    final user = _auth.currentUser;
    if (user != null) {
      final phoneNumber = user.phoneNumber!; // Use phone number as ID
      final userType = this.userType.value; // 'User' or 'Provider'

      // Check if the user exists in Firestore
      final userDoc = await _firestore
          .collection(userType == 'User' ? 'clients' : 'providers')
          .doc(phoneNumber)
          .get();

      if (!userDoc.exists) {
        // Create a new user document
        await _firestore
            .collection(userType == 'User' ? 'clients' : 'providers')
            .doc(phoneNumber)
            .set({
          'phoneNumber': phoneNumber,
          'userType': userType,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // Store user data locally
      final box = GetStorage();
      box.write('userId', phoneNumber);
      box.write('userType', userType);

      // Navigate to the appropriate page
      if (userType == 'User') {
        Get.offNamed('/MainUserPage');
      } else {
        Get.offNamed('/ProviderDashboard');
      }
    }
  }
}
