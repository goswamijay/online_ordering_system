import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';

class Space_Screen extends StatefulWidget {
  const Space_Screen({Key? key}) : super(key: key);

  @override
  State<Space_Screen> createState() => _Space_ScreenState();
}

class _Space_ScreenState extends State<Space_Screen> {
  bool _shouldFade = true;

  @override
  void initState() {
    super.initState();
    navigation();
    animation();
  }

  void navigation() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes_Name.WelcomeScreen, (route) => false);
    });
  }

  void animation() {
    Future.delayed(
        const Duration(seconds: 3),
        () => setState(() {
              _shouldFade = false;
            }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: AnimatedOpacity(
                  opacity: _shouldFade ? 1 : 0,
                  duration: const Duration(seconds: 1),
                  child: Image(
                      height: size.height / 2,
                      width: size.width / 2,
                      image: const AssetImage('logo1.png')),
                ),
              ),
              SizedBox(
                height: size.height / 40,
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


              SizedBox(
                height: size.height / 30,
              ),
              Center(
                child:  AnimatedOpacity(
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
