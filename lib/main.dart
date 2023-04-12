import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_ordering_system/Controller/ApiConnection/Authentication.dart';
import 'package:online_ordering_system/Controller/Favorite_add_provider.dart';
import 'package:online_ordering_system/Controller/place_Order_Items.dart';
import 'package:online_ordering_system/GetX/Getx_Main.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';
import 'package:online_ordering_system/Sparce_Screen.dart';
import 'package:online_ordering_system/Views/Authentication/LoginPage.dart';
import 'package:online_ordering_system/Views/Authentication/ResetPassword/ResetPasswordOTP.dart';
import 'package:online_ordering_system/firebase_options.dart';
import 'package:provider/provider.dart';
import 'Controller/ApiConnection/mainDataProvider.dart';
import 'Controller/Cart_items_provider.dart';
import 'Controller/ChangeControllerClass.dart';
import 'HomePage.dart';
import 'Utils/notificationservice/local_notification_service.dart';
import 'Views/Account Screen/AccountMainScreen.dart';
import 'Views/Account Screen/AccountResetPassword.dart';
import 'Views/Authentication/OTPScreen.dart';
import 'Views/Authentication/ResetPassword/ResetPasswordEmail.dart';
import 'Views/Authentication/ResetPassword/ResetPasswordValue.dart';
import 'Views/Authentication/SignupPage.dart';
import 'Views/Authentication/WelcomeScreen.dart';
import 'Views/Cart Screen/CartMainScreen.dart';
import 'Views/Favorite Screen/FavoriteMainScreen.dart';
import 'Views/OnboardingScreen/OnboardingScreen.dart';
import 'Views/Order Place Screen/OrderPlaceMainScreen.dart';
import 'Views/Product Screen/ProductMainScreen.dart';
import 'Views/ProductDetailsScreen/ProductDetailsScreen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  //print(message.data.toString());
  //print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
  } else {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    final fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    LocalNotificationService.initialize();
    log(fcmToken!);
  }

  //runApp(const MyApp());
  runApp(const GetApp());
/*  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };*/
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteAddProvider()),
        ChangeNotifierProvider(create: (_) => cart_items_provider()),
        ChangeNotifierProvider(create: (_) => PlaceOrderProvider()),
        ChangeNotifierProvider(create: (_) => ChangeControllerClass()),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => ApiConnection())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: GoogleFonts.lato().fontFamily,
            primaryTextTheme: GoogleFonts.latoTextTheme()),
        initialRoute: Routes_Name.SparceScreen,
        routes: {
          Routes_Name.SparceScreen: (context) => const Space_Screen(),
          Routes_Name.HomePage: (context) => const HomePage(),
          Routes_Name.WelcomeScreen: (context) => const WelcomeScreen(),
          Routes_Name.LoginScreen: (context) => const LoginPage(),
          Routes_Name.SignUpScreen: (context) => const SignUPPage(),
          Routes_Name.OTPScreen: (context) => const OTPScreen(),
          Routes_Name.ProductMainScreen: (context) => const ProductMainScreen(),
          Routes_Name.CartMainScreen: (context) => const CartMainScreen(),
          Routes_Name.FavoriteMainScreen: (context) =>
              const FavoriteMainScreen(),
          Routes_Name.AccountMainScreen: (context) => const AccountMainScreen(),
          Routes_Name.AccountResetPassword: (context) =>
              const AccountResetPassword(),
          Routes_Name.OrderPlaceMainScreen: (context) =>
              const OrderPlaceMainScreen(),
          Routes_Name.ProductDetailsScreen: (context) =>
              const ProductDetailsScreen(),
          Routes_Name.OnBoardingScreen: (context) => const OnBoardingScreen(),
          Routes_Name.ResetPasswordEmail: (context) =>
              const ResetPasswordEmail(),
          Routes_Name.ResetPasswordOTP: (context) => const ResetPasswordOTP(),
          Routes_Name.ResetPasswordValue: (context) =>
              const ResetPasswordValue(),
          Routes_Name.ProductMainScreen2: (context) => const ProductMainScreen()
        },
      ),
    );
  }
}
