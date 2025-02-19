import 'package:first_project/models/provider_model.dart';
import 'package:first_project/views/user%20views/provider_detailed_bottomSheet.dart';
import 'package:first_project/views/user%20views/provider_detailed_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class NearestProvidersPage extends StatelessWidget {
  final List<Provider> providers = [
    Provider(
      id: '1',
      name: 'Provider 1',
      location: LatLng(24.7136, 46.6753),
      distance: 1.5,
      status: 'Available',
      carSizes: ['Small', 'Medium'],
    ),
    Provider(
      id: '2',
      name: 'Provider 2',
      location: LatLng(24.7136, 46.6853),
      distance: 2.0,
      status: 'Busy',
      carSizes: ['Large'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Car Transporters'),
      ),
      body: FutureBuilder(
        future: requestLocationPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                // Map
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(30.0444, 31.2357), // Cairo coordinates
                      zoom: 12,
                    ),
                    markers: providers.map((provider) {
                      return Marker(
                        markerId: MarkerId(provider.id),
                        position: provider.location,
                        infoWindow: InfoWindow(
                          title: provider.name,
                          snippet: '${provider.distance} km away',
                        ),
                        onTap: () {
                          // Show bottom sheet with provider details
                          showModalBottomSheet(
                            context: context, // Corrected: context comes first
                            builder: (context) {
                              return ProviderDetailsBottomSheet(
                                  provider: provider);
                            },
                          );
                        },
                      );
                    }).toSet(),
                  ),
                ),
                // List of Providers
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    itemCount: providers.length,
                    itemBuilder: (context, index) {
                      final provider = providers[index];
                      return ListTile(
                        title: Text(provider.name),
                        subtitle: Text(
                            '${provider.distance} km away - ${provider.status}'),
                        trailing: Text(provider.carSizes.join(', ')),
                        onTap: () {
                          Get.to(() => ProviderDetailsPage(provider: provider));
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (!status.isGranted) {
      throw 'Location permission denied';
    }
  }
}
