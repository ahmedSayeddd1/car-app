import 'package:first_project/models/provider_model.dart';
import 'package:first_project/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderDetailsPage extends StatelessWidget {
  final Provider provider;

  ProviderDetailsPage({required this.provider});

  final _formKey = GlobalKey<FormState>();
  final _carSize = 'Small'.obs;
  final _malfunctionCause = 'Traffic Accident'.obs;
  final _isSubmitting = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Details'.tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Provider Information
              _buildProviderInfo(),
              const SizedBox(height: 24),
              Text('Please enter the following data : '.tr),

              // Car Size Selection
              _buildSectionTitle('Car Size'.tr),
              _buildCarSizeSelection(),
              const SizedBox(height: 16),

              // Malfunction Cause Selection
              _buildSectionTitle('Car Malfunction Cause'.tr),
              _buildMalfunctionCauseSelection(),
              const SizedBox(height: 16),

              // Loading Location (Static Text)
              _buildSectionTitle('Location of Loading'.tr),
              _buildStaticLocationText(),
              const SizedBox(height: 16),

              // Destination (Static Text)
              _buildSectionTitle('Destination'.tr),
              _buildStaticDestinationText(),
              const SizedBox(height: 24),

              // Submit Button
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProviderInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${provider.distance.toString().substring(0, 4)} ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                Text(
                  'km away'.tr,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${'Status'.tr}: ${provider.status}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: (provider.status == 'متاح') ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCarSizeSelection() {
    return Obx(() => Column(
          children: ['Small'.tr, 'Medium'.tr, 'Large'.tr].map((size) {
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: RadioListTile(
                title: Text(size),
                value: size,
                groupValue: _carSize.value,
                onChanged: (value) {
                  _carSize.value = value!;
                },
              ),
            );
          }).toList(),
        ));
  }

  Widget _buildMalfunctionCauseSelection() {
    return Obx(() => Column(
          children:
              ['Traffic Accident'.tr, 'Technical Malfunction'.tr].map((cause) {
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: RadioListTile(
                title: Text(cause),
                value: cause,
                groupValue: _malfunctionCause.value,
                onChanged: (value) {
                  _malfunctionCause.value = value!;
                },
              ),
            );
          }).toList(),
        ));
  }

  Widget _buildStaticLocationText() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'العبور',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildStaticDestinationText() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'مدينة نصر',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Obx(() => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _isSubmitting.value
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      _isSubmitting.value = true;
                      submitRequest();
                    }
                  },
            child: _isSubmitting.value
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Accept Request'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ));
  }

  void submitRequest() {
    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      _isSubmitting.value = false;
      Get.snackbar(
        'Success'.tr,
        'Request submitted successfully'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }
}
