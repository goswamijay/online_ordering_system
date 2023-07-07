import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/BlocEvent/BlocOnBoardingScreen/OnBoardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bloc_HomePage.dart';

class BlocSparseScreen extends StatefulWidget {
  const BlocSparseScreen({super.key});

  @override
  State<BlocSparseScreen> createState() => _BlocSparseScreenState();
}

class _BlocSparseScreenState extends State<BlocSparseScreen> {
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
    Future.delayed(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      jwtToken1 = prefs.getBool('LogInBool');
      if (jwtToken1 == true) {
        print('transfer');
        Future.delayed(const Duration(seconds: 0), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const BlocHomePage()),
            (route) => false,
          );
        });
      } else {
        Future.delayed(const Duration(seconds: 0), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const BlocOnBoardingScreen()),
            (route) => false,
          );
        });
      }
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
    Size size = MediaQuery.of(context).size;
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
                      height: size.height / 1.5,
                      width: size.width / 1.5,
                      image: const AssetImage('assets/space1.gif')),
                  //image: const AssetImage('assets/logo1.png')),
                ),
              ),

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
                child: AnimatedOpacity(
                    opacity: _shouldFade ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: SpinKitThreeBounce(
                      color: Colors.black,
                      size: size.height / 30,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
