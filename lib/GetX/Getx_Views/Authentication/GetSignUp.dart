import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Getx_Controller/GetxAuthenticationController.dart';
import '../../Getx_Utils/Getx_Routes_Name.dart';

class GetSignUp extends StatefulWidget {
  const GetSignUp({Key? key}) : super(key: key);

  @override
  State<GetSignUp> createState() => _GetSignUpState();
}

class _GetSignUpState extends State<GetSignUp> {
  final signUpController = Get.put(GetAuthenticationController());

  String name = "";
  String email = "";
  String password1 = "";
  String confirmPassword = "";
  bool changeButton = false;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupMobileController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      _formKey.currentState!.save();

      await signUpController.getSignUpUser(
          signupEmailController.text.trim(),
          signupPasswordController.text.trim(),
          signupNameController.text.trim(),
          signupMobileController.text.trim());

      await Future.delayed(const Duration(seconds: 0), () {
        if (signUpController.getSignupModelClass.status == "1") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Your account is Register".tr),
                  content: Text(
                      '${'You will Received OTP in your'.tr} ${signupEmailController.text}'),
                  actions: [
                    TextButton(
                        child: Text('Okay'.tr),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            GetxRoutes_Name.GetxOTPScreen,
                          );
                        }),
                  ],
                );
              });
        } else if (signUpController.getSignupModelClass.status == "0") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Your account is already Register".tr),
                  content: Text('Please login this account'.tr),
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
              Text(
                "Welcome".tr,
                style: const TextStyle(
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
                        controller: signupNameController,
                        decoration: InputDecoration(
                          hintText: "User Name".tr,
                          labelText: "User Name".tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "User Name can't empty".tr;
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
                        controller: signupEmailController,
                        decoration: InputDecoration(
                          hintText: "Email Id".tr,
                          labelText: "Email Id".tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Id can't empty".tr;
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
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        controller: signupMobileController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Mobile Number".tr,
                          labelText: "Mobile Number".tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mobile Number can't empty".tr;
                          } else if (value.length < 10 || value.length > 10) {
                            return "Mobile number is not valid".tr;
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
                        controller: signupPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
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
                        onChanged: (value) {
                          password1 = value;
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
                          hintText: "Confirm Password".tr,
                          labelText: "Confirm Password".tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't empty".tr;
                          } else if (value.length < 6) {
                            return "Password is less than 6 letter".tr;
                          } else if (value != password1) {
                            return "Password not matched".tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          confirmPassword = value;
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
                            : Text(
                                "SignUp".tr,
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
                        Text("You have an account? ".tr),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, GetxRoutes_Name.GetxLoginScreen);
                          },
                          child: Text("Login".tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
