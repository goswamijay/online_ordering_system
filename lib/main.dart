import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BlocCubit/BlocMainScreen.dart';
import 'BlocEvent/BlocEventMain.dart';
import 'BlocEvent/Utils/Local_Notification_Service.dart';
import 'GetX/Getx_Main.dart';
import 'Provider/MyApp.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  //print(message.data.toString());
  //print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
  } else {
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    final fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    LocalNotificationService.initialize();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmToken', fcmToken!);
    log(fcmToken!);

    String? localeString = prefs.getString('locale');
    Locale initialLocale = const Locale('en', 'US');
    if (localeString != null) {
      Map<String, dynamic> localeMap = jsonDecode(localeString);
      initialLocale =
          Locale(localeMap['languageCode'], localeMap['countryCode']);
    }

   // runApp(const MyApp());
   //  runApp(GetApp(initialLocale: initialLocale));
    // runApp(const BlocMainScreen());
    runApp(const BlocEventMain());
  }
}
