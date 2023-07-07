import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_ordering_system/Provider/Sparce_Screen.dart';
import 'package:provider/provider.dart';
import '../GetX/Getx_Views/GetOnboardingScreen/OnboardingScreen.dart';
import 'HomePage.dart';
import 'Controller/ApiConnection/Authentication.dart';
import 'Controller/ApiConnection/firebase_api_calling.dart';
import 'Controller/ApiConnection/mainDataProvider.dart';
import 'Controller/Cart_items_provider.dart';
import 'Controller/ChangeControllerClass.dart';
import 'Controller/Favorite_add_provider.dart';
import 'Controller/place_Order_Items.dart';
import 'Utils/Routes_Name.dart';
import 'Views/Account Screen/AccountMainScreen.dart';
import 'Views/Account Screen/AccountResetPassword.dart';
import 'Views/Authentication/LoginPage.dart';
import 'Views/Authentication/OTPScreen.dart';
import 'Views/Authentication/ResetPassword/ResetPasswordEmail.dart';
import 'Views/Authentication/ResetPassword/ResetPasswordOTP.dart';
import 'Views/Authentication/ResetPassword/ResetPasswordValue.dart';
import 'Views/Authentication/SignupPage.dart';
import 'Views/Authentication/WelcomeScreen.dart';
import 'Views/Cart Screen/CartMainScreen.dart';
import 'Views/Favorite Screen/FavoriteMainScreen.dart';
import 'Views/Order Place Screen/OrderPlaceMainScreen.dart';
import 'Views/Product Screen/ProductMainScreen.dart';
import 'Views/ProductDetailsScreen/ProductDetailsScreen.dart';

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
        ChangeNotifierProvider(create: (_) => ApiConnection()),
        ChangeNotifierProvider(create: (_) => FirebaseApiCalling())
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
