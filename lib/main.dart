import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_ordering_system/HomePage.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';
import 'package:online_ordering_system/Sparce_Screen.dart';
import 'package:online_ordering_system/Views/Authentication/LoginPage.dart';


import 'Views/Authentication/OTPScreen.dart';
import 'Views/Authentication/SignupPage.dart';
import 'Views/Authentication/WelcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
          primaryTextTheme: GoogleFonts.latoTextTheme()),
      initialRoute: Routes_Name.SparceScreen,
      routes: {
        Routes_Name.SparceScreen: (context) => const Space_Screen(),
        Routes_Name.HomePage : (context) => const HomePage(),
        Routes_Name.WelcomeScreen : (context) => const WelcomeScreen(),
        Routes_Name.LoginScreen : (context) => const LoginPage(),
        Routes_Name.SignUpScreen : (context) => const SignUPPage(),
        Routes_Name.OTPScreen : (context) => const OTPScreen(),
      },
    );
  }
}
