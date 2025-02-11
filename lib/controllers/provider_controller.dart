import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/models/client_request_model.dart';
import 'package:get/get.dart';

class ProviderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String providerId; // Unique provider ID (set during login)

  ProviderController({required this.providerId});

  // List of requests (now fetched from Firestore)
  final RxList<RequestModel> _serviceRequests = <RequestModel>[].obs;

  // Provider availability status
  final RxBool _isAvailable = true.obs;
  //   Track visible requests
  final int _batchSize = 10;
  var _visibleRequests = 10.obs;

  // Getters
  List<RequestModel> get serviceRequests => _serviceRequests;
  int get visibleRequests => _visibleRequests.value;
  bool get isAvailable => _isAvailable.value;

  // Load requests from Firestore
  Future<void> loadRequests() async {
    try {
      print(
          '==============Loading requests for provider: $providerId'); // Debug log
      final querySnapshot = await _firestore
          .collection('requests')
          .where('providerId', isEqualTo: "123456789")
          // .orderBy('time', descending: true)
          // للاسف مش شغال معايا -_0
          .get();
      // .where('providerId', isEqualTo: providerId)
      // .orderBy('time', descending: true) // Sort by latest first

      print(
          '==========================Number of requests fetched: ${querySnapshot.docs.length}'); // Debug log

      _serviceRequests.assignAll(
        querySnapshot.docs.map((doc) {
          print(
              '============================Document data: ${doc.data()}'); // Debug log
          return RequestModel.fromMap(doc.data());
        }).toList(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load requests: $e');
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
      await _firestore.collection('requests').doc(requestId).delete();
      await loadRequests(); // Refresh the list
      Get.snackbar('Request Hidden', 'Request has been hidden');
    } catch (e) {
      Get.snackbar('Error', 'Failed to hide request: $e');
    }
  }

  // Send an offer (update request in Firestore)
  Future<void> sendOffer(String requestId, String price) async {
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

  // Toggle provider availability
  void toggleAvailability() {
    _isAvailable.value = !_isAvailable.value;
    Get.snackbar(
      'Status Updated',
      _isAvailable.value ? 'You are now Available' : 'You are now Busy',
      snackPosition: SnackPosition.BOTTOM,
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
