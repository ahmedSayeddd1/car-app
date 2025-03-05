import 'package:first_project/helper/calculate_distance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Provider {
  final String id;
  final String name;
  final LatLng location;
  final String status;
  final List<String> carTransporterSizes;
  double distance;

  Provider({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
    required this.carTransporterSizes,
    this.distance = 0.0,
  });

  void calculateDistanceFrom(LatLng currentLocation) {
    distance = calculateDistance(
      currentLocation.latitude,
      currentLocation.longitude,
      location.latitude,
      location.longitude,
    );
  }
}
