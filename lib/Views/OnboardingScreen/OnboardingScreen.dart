import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Models/OnBoardingModelClass.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<OnBoardingModel> onBoardInfo = [
    OnBoardingModel(
        'Choose Product',
        'You Can Easily Find The Product You Want From Our Various Products!',
        'assets/OnBoarding/i.png'),
    OnBoardingModel('Choose a Payment Method',
        'We Have Many Payment Methods Supported!', 'assets/OnBoarding/ii.png'),
    OnBoardingModel(
        'Get Your Order',
        'Open The Doors, Your Order is Now Ready For You!',
        'assets/OnBoarding/iii.png'),
  ];
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          //page view
          Expanded(
            flex: 4,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              itemBuilder: (context, index) =>
                  onboardBuildPage(onBoardInfo[index]),
              itemCount: onBoardInfo.length,
              onPageChanged: (index) {
                /* if (index == onBoardInfo.length - 1) {
                  //OnBoardingCubit.get(context).listenPageLastIndex(true);
                } else
                //  OnBoardingCubit.get(context).listenPageLastIndex(false);
              },*/
              }
            ),
          ),

          //indicator, buttons
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: onBoardInfo.length,
                    effect: const WormEffect(
                      dotColor: Colors.indigo,
                      activeDotColor: Colors.orange,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      //Skip
                      TextButton(
                        onPressed: () {
                          /*CacheHelper.saveData(
                              key: 'onboardingIsSeen', value: true);
                          navigateAndRemove(context, LoginScreen());*/
                        },
                        child: const Text(
                          'SKIP',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      const Spacer(),
                      MaterialButton(
                        padding: const EdgeInsets.all(10.0),
                        onPressed: () {
                       /*   if (OnBoardingCubit
                              .get(context)
                              .isLastPage) {
                            CacheHelper.saveData(
                                key: 'onboardingIsSeen', value: true);
                            navigateAndRemove(context, LoginScreen());
                          } else {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                          }*/
                        },
                        color: Colors.orange,
                        child:  const Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        )
                         /*   : const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                          size: 24.0,
                        ),*/
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
    Widget onboardBuildPage(OnBoardingModel pageInfo) =>
        Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Image.asset(
            pageInfo.imagePath,
          ),
        ),

        //upper texts
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                pageInfo.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.indigo,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                pageInfo.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }