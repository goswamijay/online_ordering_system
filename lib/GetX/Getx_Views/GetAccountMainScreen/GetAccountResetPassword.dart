import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetAccountResetPassword extends StatefulWidget {
  const GetAccountResetPassword({Key? key}) : super(key: key);

  @override
  State<GetAccountResetPassword> createState() => _GetAccountResetPasswordState();
}

class _GetAccountResetPasswordState extends State<GetAccountResetPassword> {
  bool _passwordVisible = false;
  TextEditingController verificationCodeController = TextEditingController();

  static String name = "";
  bool changeButton = false;
  int status = 0;

  resetPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();

    final jwtToken1 = prefs.getString('jwtToken'.toString());
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/changePassword');
      var response = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken1",
          "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          {"newPass": password, "confirmPass": password},
        ),
      );

      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        status = jsonData['status'];
      } else if (response.statusCode == 400) {
        status = jsonData['status'];
      }
    } catch (e) {
      return e;
    }
  }

  moveToHome(BuildContext context) async {
    await resetPassword(verificationCodeController.text);
    Future.delayed(const Duration(seconds: 0), () {
      if (status == 1) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                    "Your password has been changed successfully,Please login again!"),
                actions: [
                  TextButton(
                      child: const Text('Okay'),
                      onPressed: () {
                        Get.offAllNamed(GetxRoutes_Name.GetxLoginScreen);
                      }),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Verification Code is Not Current"),
                actions: [
                  TextButton(
                      child: const Text('Okay'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              );
            });
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                  height: size.height / 2,
                  width: size.width,
                  image: const AssetImage("assets/forget_password.gif")),
              const Text(
                "Reset Password",
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        controller: verificationCodeController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter Password",
                          labelText: "New Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't empty";
                          } else if (value.length < 6) {
                            return "Password is less than 6 letter";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
                          } else if (value != name) {
                            return "Password not matched";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    InkWell(
                      onTap: () {
                        moveToHome(context);
                      },
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
                          "Save The Data",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
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
