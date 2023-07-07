import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlocSplashScreen extends StatefulWidget {
  const BlocSplashScreen({super.key});

  @override
  State<BlocSplashScreen> createState() => _BlocSplashScreenState();
}

class _BlocSplashScreenState extends State<BlocSplashScreen> {
  bool _shouldFade = true;

  @override
  void initState() {
    // TODO: implement initState
    navigation();
    animation();
    super.initState();
  }
  bool? jwtToken1;


  void navigation() {
    Future.delayed(const Duration(seconds: 3), () async{
      final prefs = await SharedPreferences.getInstance();
      jwtToken1 = prefs.getBool('LogInBool');
    /*  if(jwtToken1 == true){
        print('transfer');
        Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
      }else{
        Get.toNamed(GetxRoutes_Name.GetOnBoardingScreen);
      }*/
    });
  }

  void animation() {
    Future.delayed(
        const Duration(seconds: 2),
            () => setState(() {
          _shouldFade = true;
        }));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: AnimatedOpacity(
                  opacity: _shouldFade ? 1 : 0,
                  duration: const Duration(seconds: 1),
                  child: Image(
                      height: Get.height / 1.5,
                      width: Get.width / 1.5,
                      image: const AssetImage('assets/space1.gif')),
                  //image: const AssetImage('assets/logo1.png')),
                ),
              ),
              /*  SizedBox(
                height: size.height / 80,
              ),*/
              Center(
                child: AnimatedOpacity(
                  opacity: _shouldFade ? 1 : 0,
                  duration: const Duration(seconds: 1),
                  child: const Text(
                    "Online Ordering System",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Center(
                child:AnimatedOpacity(
                    opacity: _shouldFade ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: SpinKitThreeBounce(
                      color: Colors.black,
                      size: Get.height / 30,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}