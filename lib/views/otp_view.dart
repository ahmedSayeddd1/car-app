import 'package:first_project/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key});

  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Enter the 4-digit OTP sent to your phone',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _buildOtpField(index)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _controller.verifyOTP,
              child: Text('Verify OTP'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _controller.resendOTP,
              child: Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 50,
      child: TextField(
        controller: _controller.otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
            counterText: '', // Remove the character counter
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder()),
        onChanged: (value) {
          if (value.length == 1 && index < 3) {
            // Move focus to the next field

            FocusScope.of(Get.context!).nextFocus();
          } else {
            // If it's the last field, unfocus
            FocusScope.of(Get.context!).unfocus();
          }
        },
      ),
    );
  }
}
