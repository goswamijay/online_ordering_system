import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';

import '../../Getx_Controller/GetxAuthenticationController.dart';

class GetLoginPage extends StatefulWidget {
  const GetLoginPage({Key? key}) : super(key: key);

  @override
  State<GetLoginPage> createState() => _GetLoginPageState();
}

class _GetLoginPageState extends State<GetLoginPage> {
  final loginController = Get.put(GetAuthenticationController());
  TextEditingController loginEmailIdController = TextEditingController();
  TextEditingController loginPasswordIdController = TextEditingController();

  bool changeButton = false;
  bool _passwordVisible = false;

  final formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      formKey.currentState!.save();

      await loginController.getLoginUser(
          loginEmailIdController.text, loginPasswordIdController.text);

      await Future.delayed(const Duration(seconds: 0), () async {
        if (loginController.getLoginModelClass.status == "1") {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(
                "Login Successfully".tr,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.indigo,
              duration: const Duration(seconds: 1),
            ),
          );
          await Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
        } else if (loginController.getLoginModelClass.status == "0") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title:  Text("Please Register in App".tr),
                  content:  Text(
                      'Your email id is not verified kindly register again with same details and verify your account to use app!'.tr),
                  actions: [
                    TextButton(
                        child:  Text('Okay'.tr),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                );
              });
        }
      });

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
                  height: Get.height / 2.5,
                  width: Get.width,
                  image: const AssetImage("assets/hey.png")),
               Text(
                "Welcome Back".tr,
                style:const  TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        controller: loginEmailIdController,
                        decoration:  InputDecoration(
                          hintText: "User Name".tr,
                          labelText: "Username".tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username can't empty".tr;
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
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        controller: loginPasswordIdController,
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
                          hintText: "Enter Password".tr,
                          labelText: "Password".tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't empty".tr;
                          } else if (value.length < 6) {
                            return "Password is less than 6 letter".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(
                                  GetxRoutes_Name.GetxResestPasswordEmail);
                            },
                            child:  Text(
                              "Reset Password".tr,
                              style: const TextStyle(color: Colors.indigo),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: Get.height / 50,
                    ),
                    InkWell(
                      onTap: () =>  moveToHome(context),
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
                            :  Text(
                                "Login".tr,
                                style: const TextStyle(
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
                         Text("Don't have an account? ".tr),
                        InkWell(
                          onTap: () {
                            Get.toNamed(GetxRoutes_Name.GetxSignUpScreen);
                          },
                          child:  Text("SignUp".tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                              )),
                        ),
                      ],
                    )
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
