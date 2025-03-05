// models/provider_offer_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderOfferModel {
  final String id;
  final String providerId;
  final String userId;
  final String providerName;
  final double distance;
  final String price;
  final DateTime timeOfOffer;
  final String status;
  final String carSize;
  final String placeOfLoading;
  final String destination;

  ProviderOfferModel({
    required this.id,
    required this.providerId,
    required this.userId,
    required this.providerName,
    required this.distance,
    required this.price,
    required this.timeOfOffer,
    required this.status,
    required this.carSize,
    required this.placeOfLoading,
    required this.destination,
  });

  // Factory method to create an Offer from a Firestore document
  factory ProviderOfferModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProviderOfferModel(
        id: snapshot.id,
        providerId: data['providerId'] ?? '1',
        userId: data['userId'],
        providerName: data['providerName'],
        distance: data['distance'].toDouble(),
        price: data['price'],
        timeOfOffer: (data['timeOfOffer'] as Timestamp).toDate(),
        status: data['status'],
        carSize: data['carSize'],
        placeOfLoading: data['placeOfLoading'],
        destination: data['destination']);
  }

  // Convert model to Map for Firestore operations
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'providerName': providerName,
      'providerId': providerId,
      'distance': distance,
      'price': price,
      'timeOfOffer': Timestamp.fromDate(timeOfOffer),
      'status': status,
      'placeOfLoading': placeOfLoading,
      'destination': destination,
      'carSize': carSize
    };
  }
}
