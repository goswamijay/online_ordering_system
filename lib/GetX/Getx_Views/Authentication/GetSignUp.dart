import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Getx_Utils/Getx_Routes_Name.dart';
class GetSignUp extends StatefulWidget {
  const GetSignUp({Key? key}) : super(key: key);

  @override
  State<GetSignUp> createState() => _GetSignUpState();
}

class _GetSignUpState extends State<GetSignUp> {

  static String name = "";
  static String Email = "";
  static String Password1 = "";
  static String Confirm_Password = "";
  bool changeButton = false;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      _formKey.currentState!.save();
      print(Email);

      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(GetxRoutes_Name.GetxOTPScreen,arguments: {'email_id': Email.toString()});
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                  height: Get.height / 2.7,
                  width: Get.width,
                  image: const AssetImage("assets/signup.png")),
              const Text(
                "Welcome",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          labelText: "User Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "User Name can't empty";
                          }
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Email Id",
                          labelText: "Email Id",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Id can't empty";
                          }
                        },
                        onChanged: (value) {
                          Email = value;
                          print(Email);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't empty";
                          } else if (value.length < 6) {
                            return "Password is less than 6 letter";
                          }
                        },
                        onChanged: (value) {
                          Password1 = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              _passwordVisible
                                  ? (Icons.visibility)
                                  : Icons.visibility_off,
                            ),
                          ),
                          hintText: "Confirm Password",
                          labelText: "Confirm Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't empty";
                          } else if (value.length < 6) {
                            return "Password is less than 6 letter";
                          } else if (value != Password1) {
                            return "Password not matched";
                          }
                        },
                        onChanged: (value) {
                          Confirm_Password = value;
                          print(Confirm_Password);
                        },
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 30,
                    ),
                    InkWell(
                      onTap: () => moveToHome(context),
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 50,
                        width: changeButton ? 50 : 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          /*  shape: changeButton? BoxShape.circle : BoxShape.rectangle,*/
                          color: Colors.deepPurple,
                          borderRadius:
                          BorderRadius.circular(changeButton ? 50 : 8),
                        ),
                        child: changeButton
                            ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                            : const Text(
                          "Sign UP",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("You have an account? "),
                        InkWell(
                          onTap: () {
                            Get.toNamed(GetxRoutes_Name.GetxLoginScreen);
                          },
                          child: const Text("LogIn",
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(children: [
                          TextSpan(text: ("We will send you an ")),
                          TextSpan(
                              text: ("One Time Password "),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ("On this Email Id."))
                        ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
