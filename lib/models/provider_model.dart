import 'package:google_maps_flutter/google_maps_flutter.dart';

class Provider {
  final String id;
  final String name;
  final LatLng location;
  final double distance;
  final String status;
  final List<String> carSizes;

  Provider({
    required this.id,
    required this.name,
    required this.location,
    required this.distance,
    required this.status,
    required this.carSizes,
  });
}
