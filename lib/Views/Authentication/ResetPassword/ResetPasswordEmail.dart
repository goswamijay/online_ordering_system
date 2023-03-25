import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_ordering_system/Controller/ApiConnection/Authentication.dart';

import '../../../Models/ResetPasswordOtpModelClass.dart';
import '../../../Utils/Routes_Name.dart';
import 'package:http/http.dart' as http;

class ResetPasswordEmail extends StatefulWidget {
  const ResetPasswordEmail({Key? key}) : super(key: key);

  @override
  State<ResetPasswordEmail> createState() => _ResetPasswordEmailState();
}

class _ResetPasswordEmailState extends State<ResetPasswordEmail> {
  TextEditingController resetPasswordEmailController = TextEditingController();

  List<ResetPasswordOtpModelClass> list = [];
  

  moveToNext(BuildContext context) async {
    accessApi();

    Future.delayed(const Duration(seconds: 3), () {
      print(list.map((e) => e.status));
      if (list[0].status == "1") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Verification Code is send Successfully"),
                actions: [
                  TextButton(
                      child: const Text('Okay'),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes_Name.ResetPasswordOTP, arguments: {
                          'email_id':
                              resetPasswordEmailController.text.toString(),'id': list.map((e) => e.data.id)}
              ); }
                      ),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("This Email Id is not Registered With us kindly register first!"),
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

  void accessApi() async {
    list =  await Authentication.resetPassword(resetPasswordEmailController.text);

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final formKey11 = GlobalKey<FormState>();

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
                "Email ID",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Form(
                key: formKey11,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextFormField(
                        controller: resetPasswordEmailController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter Register Email ID",
                          labelText: "Enter Register Email ID",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email ID can't empty";
                          } else if (value.length < 10 || value.length > 10) {
                            return "Mobile number is not valid";
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
                        child: const Text(
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
