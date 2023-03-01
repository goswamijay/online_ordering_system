import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/Routes_Name.dart';

class AccountMainScreen extends StatefulWidget {
  const AccountMainScreen({Key? key}) : super(key: key);

  @override
  State<AccountMainScreen> createState() => _AccountMainScreenState();
}

class _AccountMainScreenState extends State<AccountMainScreen> {
  static String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
            title: const Text(
              "Account Screen",
              style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.square_arrow_left,
                    color: Colors.indigo,
                  )),
            ]),
        backgroundColor: Colors.white,*/
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                  height: size.height / 2,
                  width: size.width,
                  image: const AssetImage("account.gif")),
              const Text(
                "Account Details",
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
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: "Jay Goswami",
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: "User Name of user",
                          labelText: "User Name of user",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: "goswamijay07@gmail.com",
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: "Email Address of user",
                          labelText: "Email Address of user",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Mobile Number",
                          labelText: "Mobile Number",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mobile Number can't empty";
                          } else if (value.length < 10 || value.length > 10) {
                            return "Mobile number is not valid";
                          }
                        },
                        onChanged: (value) {
                          name = value;
                          print(name);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Address of user",
                          labelText: "Address of user",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Address of user can't empty";
                          } else if (value.length < 10) {
                            return "Address of user is not valid";
                          }
                        },
                        onChanged: (value) {
                          name = value;
                          print(name);
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
                                title: const Text("Account Details is update"),
                                actions: [
                                  TextButton(
                                      child: const Text('Okay'),
                                      onPressed: () {
                                      Navigator.of(context).pop();
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
                      height: size.height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes_Name.AccountResetPassword);
                          },
                          child: const Text("Reset Password",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
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
