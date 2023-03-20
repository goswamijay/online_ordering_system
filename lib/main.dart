import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_ordering_system/Controller/Favorite_add_provider.dart';
import 'package:online_ordering_system/Controller/Confirm_Order_Items.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';
import 'package:online_ordering_system/Sparce_Screen.dart';
import 'package:online_ordering_system/Views/Authentication/LoginPage.dart';
import 'package:online_ordering_system/Views/Cart%20Screen/Cart%20Main%20Screen.dart';
import 'package:online_ordering_system/firebase_options.dart';
import 'package:provider/provider.dart';

import 'Controller/Cart_items_provider.dart';
import 'GetX/Getx_Main.dart';
import 'HomePage.dart';
import 'Utils/notificationservice/local_notification_service.dart';
import 'Views/Account Screen/Account Main Screen.dart';
import 'Views/Account Screen/AccountResetPassword.dart';
import 'Views/Authentication/OTPScreen.dart';
import 'Views/Authentication/SignupPage.dart';
import 'Views/Authentication/WelcomeScreen.dart';
import 'Views/Favorite Screen/Favorite Main Screen.dart';
import 'Views/Order Place Screen/Order Place Main Screen.dart';
import 'Views/Product Screen/Product Main Screen.dart';
import 'Views/ProductDetailsScreen/ProductDetailsScreen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  //final fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  //print(fcmToken);
  runApp(const GetApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Favorite_add_provider()),
        ChangeNotifierProvider(create: (_) => Purchase_items_provider()),
        ChangeNotifierProvider(create: (_) => Place_order_Provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: GoogleFonts.lato().fontFamily,
            primaryTextTheme: GoogleFonts.latoTextTheme()),
        initialRoute:  Routes_Name.SparceScreen,
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
          Routes_Name.ProductDetailsScreen : (context) => const ProductDetailsScreen(),
        },
      ),
    );
  }
}
