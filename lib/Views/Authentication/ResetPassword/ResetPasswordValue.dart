import 'package:flutter/material.dart';

import '../../../Utils/Routes_Name.dart';

class ResetPasswordValue extends StatefulWidget {
  const ResetPasswordValue({Key? key}) : super(key: key);

  @override
  State<ResetPasswordValue> createState() => _ResetPasswordValueState();
}

class _ResetPasswordValueState extends State<ResetPasswordValue> {
  bool _passwordVisible = false;

  static String name = "";
  bool changeButton = false;

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
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: TextFormField(
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
                      onTap: () => {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Your Password Has been updated"),
                                actions: [
                                  TextButton(
                                      child: const Text('Okay'),
                                      onPressed: () {
                                        Navigator.pushNamedAndRemoveUntil(context, Routes_Name.LoginScreen,(route) => false);
                                      }),
                                ],
                              );
                            })
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
