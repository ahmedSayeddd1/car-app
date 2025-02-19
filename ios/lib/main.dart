import 'package:firebase_core/firebase_core.dart';

import 'package:first_project/theme/app_theme.dart';
import 'package:first_project/translations/app_translations.dart';
import 'package:first_project/views/home_view.dart';
import 'package:first_project/views/login_view.dart';
import 'package:first_project/views/otp_view.dart';
import 'package:first_project/views/provider_dashboard.dart';
import 'package:first_project/views/send_requests_foTest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: redTheme,
      title: "Car Fix App",
      locale: const Locale('ar'),
      translations: AppTranslations(),
      home: LoginPage(),
      //endRequestsPage(),
      getPages: [
        GetPage(name: '/HomeView', page: () => const HomeView()),
        GetPage(name: '/OtpView', page: () => OtpView()),
        GetPage(name: '/ProviderDashboard', page: () => ProviderDashboard())
      ],
    );
  }
}
