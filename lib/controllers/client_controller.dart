import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/models/provider_offer_model.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = 'user123'; // Replace with the actual user ID

  // Observable variable to track the current index of the bottom navigation bar
  var currentIndex = 0.obs;

  // Method to change the current index
  void changePage(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    fetchOffers();
    super.onInit();
  }

  var offers = <ProviderOfferModel>[].obs;

// Fetch offers as objects
  Future<void> fetchOffers() async {
    try {
      final querySnapshot = await _firestore
          .collection('offers')
          .where('userId', isEqualTo: userId)
          .where('status', isNotEqualTo: 'Rejected')
          // .orderBy('timeOfOffer', descending: true)
          // مش عايز يتعمل الترتيب بالوقت للاسف
          .get();

      offers.value = querySnapshot.docs
          .map((doc) => ProviderOfferModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch offers: $e');
    }
  }

  // Update status using Offer object
  Future<void> rejectOffer(ProviderOfferModel offer, String status) async {
    try {
      await _firestore.collection('offers').doc(offer.id).update({
        'status': status,
      });
      Get.snackbar('Success', 'Offer $status');
      fetchOffers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update offer status: $e');
    }
  }

  // Negotiate price using Offer object
  Future<void> negotiateOfferPrice(
      ProviderOfferModel offer, String newPrice) async {
    try {
      await _firestore.collection('offers').doc(offer.id).update({
        'price': int.parse(newPrice),
        'status': 'Negotiated',
      });
      Get.snackbar('Success', 'Price updated to $newPrice SAR');
      fetchOffers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to negotiate: $e');
    }
  }

  Future<void> sendPushNotification(String providerToken) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=ServerKey-_-', //// محتاج هنا يا جووووووو السيرفر كيي
    };
    final body = {
      'to': providerToken,
      'notification': {
        'title': 'New Order Accepted',
        'body': 'A client has accepted your offer.',
      },
      'data': {
        'orderId': 'order123', // Replace with actual order ID
        'type': 'order_accepted',
      },
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print('Push notification sent successfully');
    } else {
      print('Failed to send push notification: ${response.body}');
    }
  }

  Future<void> changeOfferStatus(
      ProviderOfferModel offer, String status) async {
    try {
      // Update the offer status to 'accepted'
      await _firestore.collection('offers').doc(offer.id).update({
        'status': status,
        'acceptedAt': FieldValue.serverTimestamp(),
      });
      fetchOffers();
      // Send a notification to the provider
      await _firestore.collection('notifications').add({
        'type': 'order_accepted',
        'orderId': offer.id,
        'userId': offer.clientId, // The client's ID
        'providerId': offer.providerId, // The provider's ID
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
        'carSize': offer.carSize, // Add car size if available
        'placeOfLoading':
            offer.placeOfLoading, // Add loading location if available
        'destination': offer.destination, // Add destination if available
      });
      // Send a push notification to the provider
      final providerDoc =
          await _firestore.collection('providers').doc(offer.providerId).get();
      final providerToken = providerDoc.data()?['fcmToken'];
      if (providerToken != null) {
        await sendPushNotification(providerToken);
      }

      if (status == 'Accepted') {
        Get.snackbar('Success', 'Offer accepted and provider notified');
      } else {
        Get.snackbar('Success', 'Offer rejected and provider notified');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to accept offer: $e');
    }
  }

//////////////////////////////////////////////////////////
  Future<void> sendRequest({
    required String clientId,
    required String providerId,
    required String carSize,
    required String malfunctionCause,
    required String loadingLocation,
    required String destination,
  }) async {
    final requestId =
        FirebaseFirestore.instance.collection('requests').doc().id;

    await FirebaseFirestore.instance.collection('requests').doc(requestId).set({
      'requestId': requestId,
      'clientId': clientId,
      'providerId': providerId,
      'carSize': carSize,
      'malfunctionCause': malfunctionCause,
      'loadingLocation': loadingLocation,
      'destination': destination,
      'status': 'Pending',
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Send a notification to the provider
    await FirebaseFirestore.instance.collection('notifications').add({
      'userId': providerId,
      'type': 'new_request',
      'message': 'You have a new request from a client.',
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
    });
  }
}
