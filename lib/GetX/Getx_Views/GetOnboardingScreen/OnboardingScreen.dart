import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Models/GetOnBoardingModelClass.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController(viewportFraction: 1, keepPage: true);

  bool? jwtToken1;

  dataAccess() async {
    final prefs = await SharedPreferences.getInstance();
    jwtToken1 = prefs.getBool('LogInBool');
    print(jwtToken1);
    print(jwtToken1.toString() != '');

    if (jwtToken1 == true) {
      print('transfer');
      Future.delayed(const Duration(seconds: 0), () {
        Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
      });
    } else {}
  }

  void permission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.notification,

      //add more permission to request here.
    ].request();
    if (status[Permission.notification] == PermissionStatus.denied) {
      Permission.notification.request();
      log("Permission Denied");
      return;
    } else {}
  }

  @override
  void initState() {
    super.initState();
    permission();
    //dataAccess();
  }

  List<OnBoardingModel> onBoardInfo = [
    OnBoardingModel(
        title: 'Choose Product'.tr,
        description:
            'You Can Easily Find \n The Product You Want From Our Various Products!'.tr,
        imagePath: 'assets/OnBoarding/i.png'),
    OnBoardingModel(
        title: 'Add item in cart'.tr,
        description:
            'You can easy to add item in \n cart and wishlist and purchase product!'.tr,
        imagePath: 'assets/OnBoarding/ii.png'),
    OnBoardingModel(
        title: 'Get Your Order'.tr,
        description: 'Open The Doors, Your Order is Now Ready For You!'.tr,
        imagePath: 'assets/OnBoarding/iii.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                flex: 6,
                child: PageView.builder(
                  controller: controller,
                  itemCount: onBoardInfo.length,
                  itemBuilder: (context, index) {
                    return onboardBuildPage(
                      text: onBoardInfo[index].title,
                      description: onBoardInfo[index].description,
                      imagePath: onBoardInfo[index].imagePath,
                    );
                  },
                )),
            Expanded(
              flex: 1,
              child: SmoothPageIndicator(
                controller: controller,
                count: onBoardInfo.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.deepPurple,
                  dotColor: Colors.deepPurple.shade200,
                  expansionFactor: 2.0,
                  dotHeight: 12,
                  dotWidth: 12,
                  // strokeWidth: 5,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              child: InkWell(
                onTap: () {
                  Get.toNamed(GetxRoutes_Name.GetxLoginScreen);
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child:  Text(
                    "Continue".tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class onboardBuildPage extends StatelessWidget {
  const onboardBuildPage(
      {Key? key,
      required this.text,
      required this.description,
      required this.imagePath})
      : super(key: key);
  final String text, description, imagePath;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Spacer(),
        /*const Text(
          "Online Ordering System",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),*/
        const Spacer(),
        Text(text,
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const Spacer(),
        AutoSizeText(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
          maxLines: 2,
        ),
        const Spacer(
          flex: 2,
        ),
        Image(
            height: size.height / 2,
            width: size.width / 2,
            image: AssetImage(imagePath)),
      ],
    );
  }
}
