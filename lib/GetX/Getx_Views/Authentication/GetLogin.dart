import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';


class GetLoginPage extends StatefulWidget {
  const GetLoginPage({Key? key}) : super(key: key);

  @override
  State<GetLoginPage> createState() => _GetLoginPageState();
}

class _GetLoginPageState extends State<GetLoginPage> {
  static String name = "";
  bool changeButton = false;
  bool _passwordVisible = false;

  final formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      formKey.currentState!.save();
      await Future.delayed(const Duration(seconds: 1));
      await Get.offAllNamed(GetxRoutes_Name.GetxHomePage);

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
              const Text(
                "Welcome Back",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          labelText: "Username",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username can't empty";
                          }
                        },
                        onChanged: (value) {
                          name = value;
                          print(name);
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
                          name = value;
                          print(name);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Reset Password",
                              style: TextStyle(color: Colors.indigo),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: Get.height / 50,
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
                          "Login",
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
                        const Text("Don't have an account? "),
                        InkWell(
                          onTap: () {
                            Get.toNamed(GetxRoutes_Name.GetxSignUpScreen);
                          },
                          child: const Text("SignUp",
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink,)),
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
