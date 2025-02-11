import 'package:first_project/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'.tr),
        centerTitle: true,
        actions: [
          DropdownButton<String>(
            iconEnabledColor: Colors.white,
            dropdownColor: Color.fromARGB(255, 172, 62, 54),
            iconDisabledColor: Color.fromARGB(255, 180, 132, 129),
            value: _controller.selectedLanguage.value,
            onChanged: (String? newValue) {
              _controller.changeLanguage(newValue!);
            },
            items: <String>['en', 'ar', 'ur']
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem(
                    value: value,
                    child: Text(value.tr),
                  ),
                )
                .toList(),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/carRepair-removebg-preview.png',
              height: 250,
            ),
            Text(
              'select your account type :'.tr,
              style: TextStyle(color: Color.fromARGB(255, 172, 62, 54)),
            ),
            Obx(
              () => DropdownButton<String>(
                elevation: 100,
                iconEnabledColor: Color.fromARGB(255, 172, 62, 54),
                style: TextStyle(
                  color: Color.fromARGB(255, 172, 62, 54),
                ),
                value: _controller.userType.value,
                onChanged: (String? newValue) {
                  _controller.userType.value = newValue!;
                },
                items: <String>['User', 'Provider']
                    .map(
                      (String value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.tr),
                      ),
                    )
                    .toList(),
                dropdownColor: Color.fromARGB(255, 180, 132, 129),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller.phoneController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 172, 62, 54))),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 172, 62, 54))),
                  labelText: 'phoneNumber'.tr,
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 172, 62, 54)),
                  hintText: 'Enter your phone number',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 172, 62, 54))),
              keyboardType: TextInputType.phone,
            ),
            Obx(() => _controller.isCodeSent.value
                ? TextField(
                    controller: _controller.otpController,
                    decoration: InputDecoration(
                      labelText: 'otp'.tr,
                      hintText: 'Enter OTP',
                    ),
                    keyboardType: TextInputType.number,
                  )
                : SizedBox()),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 172, 62, 54)),
              onPressed: () {
                _controller.phoneNumberVerification;
                Get.offNamed('/OtpView');
              },
              child: Text(
                'sendOTP'.tr,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
