import 'package:first_project/controllers/login_controller.dart';
import 'package:first_project/values/colors.dart';
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
            dropdownColor: primary,
            //const Color.fromARGB(255, 172, 62, 54),
            iconDisabledColor: const Color.fromARGB(255, 180, 132, 129),
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
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset(
              'assets/images/carLogo.webp',
              //  'assets/images/carRepair-removebg-preview.png',
              height: 250,
            ),
            const SizedBox(
              height: 21,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Align text and dropdown to the left
              children: [
                // Title Text
                Text(
                  'select your account type :'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height: 16), // Reduced spacing for better hierarchy

                // Decorated Dropdown
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[
                          100], // Background color of the dropdown container
                      borderRadius:
                          BorderRadius.circular(10)), // Rounded corners
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16), // Inner padding
                  child: Obx(
                    () => DropdownButton<String>(
                      isExpanded: true, // Ensure the dropdown takes full width
                      elevation: 8, // Shadow effect
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Color.fromARGB(
                              255, 172, 62, 54)), // Custom dropdown icon
                      iconSize: 30, // Icon size
                      iconEnabledColor:
                          const Color.fromARGB(255, 172, 62, 54), // Icon color
                      dropdownColor:
                          Colors.white, // Background color of the dropdown menu
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Text color
                        fontWeight: FontWeight.w500,
                      ),
                      value: _controller.userType.value,
                      onChanged: (String? newValue) {
                        _controller.userType.value = newValue!;
                      },
                      items: <String>['User', 'Provider'].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value.tr,
                            style: const TextStyle(
                              color:
                                  Colors.black, // Text color in dropdown menu
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        'Select account type'
                            .tr, // Hint text when no value is selected
                        style: const TextStyle(
                          color: Colors.grey, // Hint text color
                        ),
                      ),
                      underline: Container(), // Remove the default underline
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Enter your phone number'.tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _controller.phoneController,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: '+20',
                  //'phoneNumber'.tr,
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: 'Enter your phone number'.tr,
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 172, 62, 54))),
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
                : const SizedBox()),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                onPressed: () {
                  //_controller.phoneNumberVerification;
                  Get.offNamed('/OtpView');
                },
                child: Text(
                  'sendOTP'.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
