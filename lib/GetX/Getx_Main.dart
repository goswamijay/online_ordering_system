import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/LocaleString.dart';
import 'package:online_ordering_system/GetX/Getx_Views/Authentication/GetLogin.dart';
import 'package:online_ordering_system/GetX/Getx_Views/Authentication/GetOtpScreen.dart';
import 'package:online_ordering_system/GetX/Getx_Views/Authentication/GetSignUp.dart';
import 'package:online_ordering_system/GetX/Getx_Views/Authentication/ResetPassword/GetResetPasswordOTP.dart';
import 'package:online_ordering_system/GetX/Getx_Views/GetAccountMainScreen/GetAccountResetPassword.dart';
import 'package:online_ordering_system/GetX/Getx_Views/GetCartMainScreen/GetCartMainScreen.dart';

import 'Getx_Controller/getAllControllerBinding.dart';
import 'Getx_Sparce_Screen.dart';
import 'GetHomePage.dart';
import 'Getx_Views/Authentication/ResetPassword/GetResetPasswordEmail.dart';
import 'Getx_Views/GetAccountMainScreen/GetAccountMainScreen.dart';
import 'Getx_Views/GetDetailsProductScreen/GetDetailsProductScreen.dart';
import 'Getx_Views/GetFavoriteMainScreen/GetFavoriteMainScreen.dart';
import 'Getx_Views/GetOnboardingScreen/OnboardingScreen.dart';
import 'Getx_Views/GetOrderPlaceMainScreen/GetOrderPlaceMainScreen.dart';

class GetApp extends StatelessWidget {
  const GetApp({Key? key,required this.initialLocale}) : super(key: key);
  final Locale initialLocale;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetAllControllerBinding(),
      //Transition Effect
      enableLog: true,
      defaultTransition: Transition.fade,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Get.defaultTransitionDuration,

      //Translation ENG AND HINDI
      translations: LocaleString(),
      locale: initialLocale,
      debugShowCheckedModeBanner: false,
      initialRoute: GetxRoutes_Name.GetxSparceScreen1,
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(background: const Color.fromRGBO(246, 244, 244, 1)),
        // brightness: themeController.isDarkMode.value ? Brightness.dark : Brightness.light,
      ),
      routes: {
        GetxRoutes_Name.GetxSparceScreen1: (context) =>
            const GetxSparceScreen(),
        GetxRoutes_Name.GetxLoginScreen: (context) => const GetLoginPage(),
        GetxRoutes_Name.GetxSignUpScreen: (context) => const GetSignUp(),
        GetxRoutes_Name.GetxOTPScreen: (context) => const GetOtpScreen(),
        GetxRoutes_Name.GetxHomePage: (context) => const GetHomePage(),
        GetxRoutes_Name.GetxFavoriteMainScreen: (context) =>
            const GetFavoriteMainScreen(),
        GetxRoutes_Name.GetxCartMainScreen: (context) =>
            const GetCartMainScreen(),
        GetxRoutes_Name.GetxAccountMainScreen: (context) =>
            const GetAccountMainScreen(),
        GetxRoutes_Name.GetxAccountResetPassword: (context) =>
            const GetAccountResetPassword(),
        GetxRoutes_Name.GetxOrderPlaceMainScreen: (context) =>
            const GetOrderPlaceMainScreen(),
        GetxRoutes_Name.GetxProductDetailsScreen: (context) =>
            const GetDetailsProductScreen(),
        GetxRoutes_Name.GetxResestPasswordEmail: (context) =>
            const GetResetPasswordEmail(),
        GetxRoutes_Name.GetxResestPasswordOTP: (context) =>
            const GetResetPasswordOTP(),
        GetxRoutes_Name.GetOnBoardingScreen: (context) =>
            const OnBoardingScreen(),
      },
    );
  }
}
