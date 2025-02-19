import 'package:first_project/models/provider_model.dart';
import 'package:first_project/views/user%20views/nearest_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderDetailsPage extends StatelessWidget {
  final Provider provider;

  ProviderDetailsPage({required this.provider});

  final _formKey = GlobalKey<FormState>();
  final _carSize = 'Small'.obs;
  final _malfunctionCause = 'Traffic Accident'.obs;
  final _loadingLocation = 'Current Location'.obs;
  final _destination = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(provider.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('${provider.distance} km away'),
              Text('Status: ${provider.status}'),
              SizedBox(height: 16),
              Text('Car Size', style: TextStyle(fontSize: 18)),
              Obx(() => Column(
                    children: ['Small', 'Medium', 'Large'].map((size) {
                      return RadioListTile(
                        title: Text(size),
                        value: size,
                        groupValue: _carSize.value,
                        onChanged: (value) {
                          _carSize.value = value!;
                        },
                      );
                    }).toList(),
                  )),
              SizedBox(height: 16),
              Text('Car Malfunction Cause', style: TextStyle(fontSize: 18)),
              Obx(() => Column(
                    children: ['Traffic Accident', 'Technical Malfunction']
                        .map((cause) {
                      return RadioListTile(
                        title: Text(cause),
                        value: cause,
                        groupValue: _malfunctionCause.value,
                        onChanged: (value) {
                          _malfunctionCause.value = value!;
                        },
                      );
                    }).toList(),
                  )),
              SizedBox(height: 16),
              Text('Location of Loading', style: TextStyle(fontSize: 18)),
              // Add dropdowns for governorate, city, and neighborhood
              SizedBox(height: 16),
              Text('Destination', style: TextStyle(fontSize: 18)),
              // Add dropdowns for governorate, city, and neighborhood
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submit request to Firestore
                    submitRequest();
                  }
                },
                child: Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitRequest() {
    // TODO: Implement Firestore submission logic
    Get.snackbar('Success', 'Request submitted successfully');
  }
}
