import 'package:first_project/models/provider_model.dart';
import 'package:first_project/views/user%20views/nearest_providers.dart';
import 'package:first_project/views/user%20views/provider_detailed_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderDetailsBottomSheet extends StatelessWidget {
  final Provider provider;

  ProviderDetailsBottomSheet({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(provider.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('${provider.distance} km away'),
          Text('Status: ${provider.status}'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Get.to(() => ProviderDetailsPage(provider: provider));
            },
            child: Text('View Details'),
          ),
        ],
      ),
    );
  }
}
