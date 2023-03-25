import 'package:flutter/material.dart';

import '../../../Controller/ApiConnection/Authentication.dart';
import '../../../Models/ResetPasswordOtpModelClass.dart';
import '../../../Utils/Routes_Name.dart';

class ResetPasswordValue extends StatefulWidget {
  const ResetPasswordValue({Key? key}) : super(key: key);

  @override
  State<ResetPasswordValue> createState() => _ResetPasswordValueState();
}

class _ResetPasswordValueState extends State<ResetPasswordValue> {
  bool _passwordVisible = false;
  Map<String, dynamic>? argument = {};
  List<ResetPasswordOtpModelClass1> list1 = [];
  TextEditingController verificationCodeController = TextEditingController();

  static String name = "";
  bool changeButton = false;

  moveToHome(BuildContext context) async {
    accessApi();
    Future.delayed(const Duration(seconds: 3), () {
      if (list1[0].status == "1") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Your password has been changed successfully,Please login again!"),
                actions: [
                  TextButton(
                      child: const Text('Okay'),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes_Name.LoginScreen, (route) => false);
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

  void accessApi() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      list1 = await Authentication.resetPassword2(
          argument!['id'].toString().replaceAll('(', '').replaceAll(')', ''),
          verificationCodeController.text);
    });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    argument =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
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
                      onTap: ()  {
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
