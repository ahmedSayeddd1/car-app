class RequestModel {
  final String id;
  final DateTime time;
  final String destination;
  final String carSize;
  final String carStatus;
  String servicePricing;
  final String placeOfLoading;
  final String providerId;
  final String status; // field مهم

  RequestModel({
    required this.id,
    required this.time,
    required this.destination,
    required this.carSize,
    required this.carStatus,
    required this.servicePricing,
    required this.placeOfLoading,
    required this.providerId,
    required this.status,
  });

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
      'status': status, // Add this field
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> data) {
    return RequestModel(
      id: data['id'],
      time: data['time'].toDate(),
      destination: data['destination'],
      carSize: data['carSize'],
      carStatus: data['carStatus'],
      servicePricing: data['servicePricing'],
      placeOfLoading: data['placeOfLoading'],
      providerId: data['providerId'],
      status: data['status'], // Add this field
    );
  }
}
