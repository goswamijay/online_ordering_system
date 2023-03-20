import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import 'package:online_ordering_system/GetX/Getx_Views/Authentication/GetLogin.dart';
import 'package:online_ordering_system/GetX/Getx_Views/Authentication/GetOtpScreen.dart';
import 'package:online_ordering_system/GetX/Getx_Views/Authentication/GetSignUp.dart';
import 'package:online_ordering_system/GetX/Getx_Views/GetCartMainScreen/GetCartMainScreen.dart';

import 'Getx_Sparce_Screen.dart';
import 'GetHomePage.dart';
import 'Getx_Views/GetFavorite/GetFavoriteMainScreen.dart';

class GetApp extends StatelessWidget {
  const GetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: GetxRoutes_Name.GetxHomePage,
      routes: {
        GetxRoutes_Name.GetxSparceScreen1: (context) => const GetxSparceScreen(),
        GetxRoutes_Name.GetxLoginScreen : (context) => const GetLoginPage(),
        GetxRoutes_Name.GetxSignUpScreen : (context) => const GetSignUp(),
        GetxRoutes_Name.GetxOTPScreen : (context) => const GetOtpScreen(),
        GetxRoutes_Name.GetxHomePage : (context) => const GetHomePage(),
        GetxRoutes_Name.GetxFavoriteMainScreen : (context) => const GetFavoriteMainScreen(),
        GetxRoutes_Name.GetxCartMainScreen : (context) => const GetCartMainScreen()
      },
    );
  }
}
