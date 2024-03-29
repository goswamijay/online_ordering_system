import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BlocEvent/Utils/Local_Notification_Service.dart';
import 'Utils/Routes_Name.dart';

class Space_Screen extends StatefulWidget {
  const Space_Screen({Key? key}) : super(key: key);

  @override
  State<Space_Screen> createState() => _Space_ScreenState();
}

class _Space_ScreenState extends State<Space_Screen> {
  bool _shouldFade = true;

  bool? jwtToken1;

  dataAccess() async {
    final prefs = await SharedPreferences.getInstance();
    jwtToken1 = prefs.getBool('LogInBool');
    print(jwtToken1);
    print(jwtToken1.toString() != '');

    if (jwtToken1 == true) {
      print('transfer');
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, Routes_Name.HomePage);
      });
    } else {
      navigation();
    }
  }

  @override
  void initState() {
    super.initState();
    animation();
    dataAccess();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
  }

  void navigation() {
    Future.delayed(const Duration(seconds: 3), () {
      /*   Navigator.pushNamedAndRemoveUntil(
          context, Routes_Name.LoginScreen, (route) => false);*/
      Navigator.pushNamedAndRemoveUntil(
          context, Routes_Name.OnBoardingScreen, (route) => false);
    });
  }

  void animation() {
    if (mounted) {
      Future.delayed(
          const Duration(seconds: 2),
          () => setState(() {
                _shouldFade = false;
              }));
    }
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
