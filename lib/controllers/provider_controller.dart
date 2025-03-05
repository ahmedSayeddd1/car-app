import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_project/models/client_request_model.dart';
import 'package:first_project/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class ProviderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String providerId;
  final String? userId; // Unique provider ID (set during login)

  ProviderController({required this.providerId, this.userId});

  // List of requests (now fetched from Firestore)
  final RxList<RequestModel> _serviceRequests = <RequestModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxList<RequestModel> _accomplishedOrders = <RequestModel>[].obs;

  // Observable list of notifications
  var notifications = <NotificationModel>[].obs;

  // Provider availability status
  final RxBool _isAvailable = true.obs;
  //   Track visible requests
  final int _batchSize = 10;
  var _visibleRequests = 10.obs;
  final RxString selectedLanguage = 'en'.obs;

  // Getters
  List<RequestModel> get serviceRequests => _serviceRequests;
  int get visibleRequests => _visibleRequests.value;
  bool get isAvailable => _isAvailable.value;
  List<RequestModel> get accomplishedOrders => _accomplishedOrders;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchOrders();
    fetchNotifications(); // Fetch notifications when the controller is initialized
  }

  void changeLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    Get.updateLocale(Locale(languageCode)); // Update the app locale
  }

  // Load requests from Firestore
  Future<void> loadRequests() async {
    _isLoading.value = true;
    try {
      final querySnapshot = await _firestore
          .collection('requests')
          .where('providerId', isEqualTo: "123456789")
          .where('hiddenByProvider', isEqualTo: false) // Exclude hidden orders
          // .orderBy('time', descending: true)
          // للاسف مش شغال معايا -_0
          .get();
      // .where('providerId', isEqualTo: providerId)
      // .orderBy('time', descending: true) // Sort by latest first

      _serviceRequests.assignAll(
        querySnapshot.docs.map((doc) {
          print(
              '============================Document data: ${doc.data()}'); // Debug log
          return RequestModel.fromMap(doc.data());
        }).toList(),
      );
      if (_visibleRequests.value > _serviceRequests.length) {
        _visibleRequests.value = _serviceRequests.length;
      } else {
        _visibleRequests.value = 10;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load requests: $e');
    } finally {
      _isLoading.value = false;
    }
  }

/////////////////////////////////////////////////////
// Fetch accomplished orders
  Future<void> fetchAccomplishedOrders() async {
    _isLoading.value = true;
    try {
      final querySnapshot = await _firestore
          .collection('requests')
          .where('providerId', isEqualTo: providerId)
          .where('status', isEqualTo: 'accomplished') // Filter by status
          .get();

      _accomplishedOrders.assignAll(
        querySnapshot.docs
            .map((doc) => RequestModel.fromMap(doc.data()))
            .toList(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch accomplished orders: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  // Add a new request to Firestore
  Future<void> addRequest(RequestModel request) async {
    try {
      print(
          '<><><><><>><>Adding request to Firestore: ${request.id}'); // Debug log
      await _firestore
          .collection('requests')
          .doc(request.id)
          .set(request.toMap());
      print(
          '////////////////////////Request added successfully: ${request.id}'); // Debug log
      await loadRequests(); // Refresh the list
    } catch (e, stackTrace) {
      print(
          '===========addReQuestError================Error adding request: $e'); // Debug log
      print(
          '===================addReQuestError==========Stack Trace: $stackTrace'); // Debug log
      Get.snackbar('Error', 'Failed to add request: $e');
    }
  }

  // Hide a request (delete from Firestore)
  Future<void> hideRequest(String requestId) async {
    try {
      await _firestore
          .collection('requests')
          .doc(requestId)
          .update({"hiddenByProvider": true});
      // مسحنا من الفايربيز
      // _serviceRequests.removeWhere((request) => request.id == requestId);
      // كده اتاكدت اني مسحت برضو من الليست هنا
      await loadRequests(); // Refresh the list
      if (_visibleRequests.value > _serviceRequests.length) {
        _visibleRequests.value = _serviceRequests.length;
      } // هنا باكد قيمة الفيزيبل ريكويستس عشان ال item count of the listview.builder
      Get.snackbar('Request Hidden', 'Request has been hidden');
    } catch (e) {
      Get.snackbar('Error', 'Failed to hide request: $e');
    }
  }

  // Send an offer (update request in Firestore)
  Future<void> sendOffer(String requestId, String price) async {
    // Validate service pricing
    if (price.isEmpty ||
        double.tryParse(price) == null ||
        double.parse(price) <= 0) {
      Get.snackbar(
        'Invalid Price',
        'Please enter a valid price greater than zero.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      return; // Exit the method if validation fails
    }

    try {
      await _firestore.collection('requests').doc(requestId).update({
        'servicePricing': price,
      });
      await loadRequests(); // Refresh the list
      Get.snackbar('Offer Sent', 'Offer sent for Request');
    } catch (e) {
      Get.snackbar('Error', 'Failed to send offer: $e');
    }
  }

  Color toogleColor = Colors.green;
  // Toggle provider availability
  void toggleAvailability() {
    _isAvailable.value = !_isAvailable.value;
    if (_isAvailable.value) {
      toogleColor = Colors.green;
      update();
    } else {
      toogleColor = Colors.red;
      update();
    }
    Get.snackbar(
      duration: const Duration(seconds: 1),
      //  'Status Updated',
      _isAvailable.value ? 'You are now Available'.tr : 'You are now Busy'.tr,
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: _isAvailable.value ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
  }

  void loadMoreRequests() {
    if (_visibleRequests.value < _serviceRequests.length) {
      _visibleRequests.value += _batchSize;
      if (_visibleRequests.value > _serviceRequests.length) {
        _visibleRequests.value = _serviceRequests.length;
      }
    }
  }

  final RxString _selectedFilter = 'accomplished'.obs;

  // Getter for selected filter
  String get selectedFilter => _selectedFilter.value;

  // Method to update the filter
  void updateFilter(String filter) {
    _selectedFilter.value = filter;
    fetchOrders(); // Fetch orders based on the new filter
  }

  // Updated method to fetch orders based on the selected filter
  Future<void> fetchOrders() async {
    _isLoading.value = true;
    try {
      final querySnapshot = await _firestore
          .collection('requests')
          .where('providerId', isEqualTo: providerId)
          .where('status',
              isEqualTo: _selectedFilter.value) // Filter by selected status
          .get();

      _accomplishedOrders.assignAll(
        querySnapshot.docs
            .map((doc) => RequestModel.fromMap(doc.data()))
            .toList(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  ///////////////////////////////////////////////
  ///
  ///
  ///

  Future<void> testFirestoreConnection() async {
    try {
      await _firestore.collection('test').doc('test_doc').set({
        'message': 'Hello, Firestore!',
      });
      print('Test document added successfully');
    } catch (e, stackTrace) {
      print('===========Firestore Test Error================');
      print('Error: $e'); // Debug log
      print('Stack Trace: $stackTrace'); // Debug log
    }
  }

  void startLocationUpdates(String orderId) {
    Geolocator.getPositionStream().listen((Position position) {
      _firestore.collection('offers').doc(orderId).update({
        'trackingLocation': GeoPoint(position.latitude, position.longitude),
      });
    });
  }

  Future<void> confirmOrder(String orderId) async {
    try {
      // 1. Update offer status
      await _firestore.collection('offers').doc(orderId).update({
        'status': 'confirmed',
        'confirmedAt': FieldValue.serverTimestamp(),
      });

      // Mark the notification as read
      await _firestore.collection('notifications').doc(orderId).update({
        'read': true,
      });

      // 2. Set provider as busy
      toggleAvailability();

      // 3. Send notification to client
      await _firestore.collection('notifications').add({
        'type': 'confirmation',
        'orderId': orderId,
        'message': 'Provider has confirmed your order',
        'userId': userId,
        'providerId': providerId,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
      });
      // Refresh notifications
      fetchNotifications();

      // 4. Start location tracking
      startLocationUpdates(orderId);
    } catch (e) {
      Get.snackbar('Error', 'Confirmation failed: $e');
    }
  }

  ////////////
  // Fetch notifications from Firestore
  Future<void> fetchNotifications() async {
    try {
      final querySnapshot = await _firestore
          .collection('notifications')
          .where('providerId', isEqualTo: providerId)
          .orderBy('timestamp', descending: true)
          .get();

      notifications.value = querySnapshot.docs
          .map((doc) => NotificationModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch notifications: $e');
    }
  }

  Future<void> saveFCMToken(String providerId) async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    final String? token = await messaging.getToken();

    if (token != null) {
      await _firestore.collection('providers').doc(providerId).update({
        'fcmToken': token,
      });
    }
  }
}

// import 'package:first_project/models/client_request_model.dart';
// import 'package:get/get.dart';

// class ProviderController extends GetxController {
//   Dummy data for service requests (now using RequestModel)
//   final RxList<RequestModel> _serviceRequests = List.generate(
//     20,
//     (index) => RequestModel(
//       id: index + 1,
//       time: '10:${index < 10 ? '0$index' : index} AM',
//       placeOfLoading: 'Loading Point ${index + 1}',
//       destination: 'Location ${index + 1}',
//       carSize: 'Medium',
//       carStatus: 'Broken Engine',
//       servicePricing: '0', // Initial price
//     ),
//   ).obs;

//   Track visible requests
//   final int _batchSize = 10;
//   var _visibleRequests = 10.obs;

//   Provider status
//   var _isAvailable = true.obs;

//   Getters
//   List<RequestModel> get serviceRequests => _serviceRequests;
//   int get visibleRequests => _visibleRequests.value;
//   bool get isAvailable => _isAvailable.value;

//   Load more requests
//   void loadMoreRequests() {
//     if (_visibleRequests.value < _serviceRequests.length) {
//       _visibleRequests.value += _batchSize;
//       if (_visibleRequests.value > _serviceRequests.length) {
//         _visibleRequests.value = _serviceRequests.length;
//       }
//     }
//   }

//   Hide a request
//   void hideRequest(int index) {
//     _serviceRequests.removeAt(index);
//     _visibleRequests.value--;
//     Get.snackbar(
//       'Request Hidden',
//       'Request #${_serviceRequests[index].id} has been hidden',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   Send an offer
//   void sendOffer(int index) {
//     if (_serviceRequests[index].servicePricing == '0') {
//       Get.snackbar(
//         'Error',
//         'Please enter a valid price',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } else {
//       Get.snackbar(
//         'Offer Sent',
//         'Offer sent for Request #${_serviceRequests[index].id}',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       TODO: Send offer to client
//     }
//   }

//   Toggle provider status
//   void toggleAvailability() {
//     _isAvailable.value = !_isAvailable.value;
//     Get.snackbar(
//       'Status Updated',
//       _isAvailable.value ? 'You are now Available' : 'You are now Busy',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }
