class RequestModel {
  final String id; // Change to String for Firestore document ID
  final DateTime time; // Changed to DateTime
  final String destination;
  final String carSize;
  final String carStatus;
  String servicePricing;
  final String placeOfLoading;
  final String providerId; // Unique provider ID

  RequestModel({
    required this.id,
    required this.time,
    required this.destination,
    required this.carSize,
    required this.carStatus,
    required this.servicePricing,
    required this.placeOfLoading,
    required this.providerId,
  });

  // Convert RequestModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'destination': destination,
      'carSize': carSize,
      'carStatus': carStatus,
      'servicePricing': servicePricing,
      'placeOfLoading': placeOfLoading,
      'providerId': providerId,
    };
  }

  // Create a RequestModel from a Firestore document
  factory RequestModel.fromMap(Map<String, dynamic> data) {
    return RequestModel(
      id: data['id'],
      time: data['time'].toDate(),
      // Convert Firestore Timestamp to DateTime // Convert Firestore Timestamp to DateTime
      destination: data['destination'],
      carSize: data['carSize'],
      carStatus: data['carStatus'],
      servicePricing: data['servicePricing'],
      placeOfLoading: data['placeOfLoading'],
      providerId: data['providerId'],
    );
  }
}
