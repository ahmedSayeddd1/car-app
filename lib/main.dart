import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:first_project/theme/app_theme.dart';
import 'package:first_project/translations/app_translations.dart';
import 'package:first_project/views/home_view.dart';
import 'package:first_project/views/login_view.dart';
import 'package:first_project/views/otp_view.dart';
import 'package:first_project/views/provider%20views/provider_dashboard.dart';
import 'package:first_project/views/test_firebase_pages/send_requests_foTest.dart';
import 'package:first_project/views/test_firebase_pages/test_offers_page.dart';
import 'package:first_project/views/user%20views/main_user_page.dart';
import 'package:first_project/views/user%20views/nearest_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(); // Initialize Firebase Messaging
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for notifications (iOS only)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Get the FCM token
  String? token = await messaging.getToken();
  print('FCM Token: $token');

  // Listen for incoming messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(
        'Received a message while in the foreground: ${message.notification?.title}');
    // Show a local notification or update the UI
  });
  // Set the background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
      //NearestProvidersPage(),
      //endRequestsPage(),
      getPages: [
        GetPage(name: '/HomeView', page: () => const HomeView()),
        GetPage(name: '/OtpView', page: () => OtpView()),
        GetPage(name: '/ProviderDashboard', page: () => ProviderDashboard())
      ],
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.notification?.title}');
  // Show a local notification or update the UI
}
