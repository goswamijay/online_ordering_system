import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';

class GetAccountMainScreen extends StatefulWidget {
  const GetAccountMainScreen({Key? key}) : super(key: key);

  @override
  State<GetAccountMainScreen> createState() => _GetAccountMainScreenState();
}

class _GetAccountMainScreenState extends State<GetAccountMainScreen> {
  static String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12.0),
            child: InkWell(
                onTap: () {
                  Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
                },
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.black,
                  ),
                )),
          ),

          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0, top: 12.0),
              child: InkWell(
                onTap: () {
                },
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(20),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FittedBox(
                      child: Icon(
                        CupertinoIcons.square_arrow_left,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                  height: Get.height / 2,
                  width: Get.width,
                  image: const AssetImage("assets/account.gif")),
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
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
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
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
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
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
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
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 50,
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
                      height: Get.height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(GetxRoutes_Name.GetxAccountResetPassword);
                          },
                          child: const Text("Reset Password",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height / 20,
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