import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';

class GetResetPasswordEmail extends StatefulWidget {
  const GetResetPasswordEmail({Key? key}) : super(key: key);

  @override
  State<GetResetPasswordEmail> createState() => _GetResetPasswordEmailState();
}

class _GetResetPasswordEmailState extends State<GetResetPasswordEmail> {
  TextEditingController resetPasswordEmailController = TextEditingController();

  String emailId = '';
  String userId = '';
  int status = 0;
  String emailExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  forgotPassword(String emailId) async {
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/forgotPassword');
      var response = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          {
            "emailId": emailId,
          },
        ),
      );

      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        emailId = jsonData['data']['emailId'];
        userId = jsonData['data']['_id'];
        status = jsonData['status'];
      } else if (response.statusCode == 400) {
        status = jsonData['status'];
      }
    } catch (e) {
      return e;
    }
  }

  moveToNext(BuildContext context) async {
    await forgotPassword(resetPasswordEmailController.text);

    Future.delayed(const Duration(seconds: 0), () {
      if (status == 1) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Verification Code is send Successfully".tr),
                actions: [
                  TextButton(
                      child: Text('Okay'.tr),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, GetxRoutes_Name.GetxResestPasswordOTP,
                            arguments: {
                              'email_id': resetPasswordEmailController.text,
                              'userId': userId
                            });
                      }),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                    "This Email Id is not Registered With us kindly register first!"
                        .tr),
                actions: [
                  TextButton(
                      child: Text('Okay'.tr),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                  height: size.height / 2,
                  width: size.width,
                  image: const AssetImage("assets/forget_password.gif")),
              Text(
                "Email ID".tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        controller: resetPasswordEmailController,
                        decoration: InputDecoration(
                          hintText: "Enter Register Email ID".tr,
                          labelText: "Enter Register Email ID".tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email ID can't empty".tr;
                          } else {
                            String emailExp =
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                            RegExp regExp = RegExp(emailExp);
                            if (regExp.hasMatch(value)) {
                            } else {
                              return "Please Enter Valid Email".tr;
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    InkWell(
                      onTap: () {
                        moveToNext(context);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 50,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          /*  shape: changeButton? BoxShape.circle : BoxShape.rectangle,*/
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Forget Password".tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: ("We will send you an ".tr)),
                      TextSpan(
                          text: ("One Time Password ".tr),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ("On this Email Id.".tr))
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
