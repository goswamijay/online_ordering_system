import 'package:flutter/material.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(147, 243, 249, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
                height: size.height/2 ,
                width: size.width,
                image: const AssetImage('first.jpg')),
            const Text(
              "Online Ordering System",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 28),
            ),

            SizedBox(
              height: size.height / 40,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                    onTap: (){Navigator.pushNamed(context, Routes_Name.LoginScreen);},

                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: 50,
                  width: size.width / 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    /*  shape: changeButton? BoxShape.circle : BoxShape.rectangle,*/
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: size.height / 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                // onTap: (){Navigator.pushNamed(context, Routes.SignUP);},

                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: 50,
                  width: size.width / 1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    /*  shape: changeButton? BoxShape.circle : BoxShape.rectangle,*/
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Sign UP",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
