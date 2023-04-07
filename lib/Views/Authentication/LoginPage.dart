import 'package:flutter/material.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';
import 'package:provider/provider.dart';
import '../../Controller/ApiConnection/Authentication.dart';
import '../../Models/LoginModelClass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;
  bool _passwordVisible = false;
  List<LoginModelClass> list = [];

  final formKey = GlobalKey<FormState>();
  TextEditingController loginEmailIdController = TextEditingController();
  TextEditingController loginPasswordIdController = TextEditingController();

  moveToHome(BuildContext context) async {
    final loginProvider = Provider.of<Authentication>(context, listen: false);
    await loginProvider.loginUser(loginEmailIdController.text.trim(),
        loginPasswordIdController.text.trim());

    if (formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      formKey.currentState!.save();

      await Future.delayed(const Duration(seconds: 0), () {
        if (loginProvider.loginData[0].status == "1") {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes_Name.HomePage, (route) => false);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Login Successfully",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.indigo,
              duration: Duration(seconds: 1),
            ),
          );
          /* showDialog(
              context: context,
              builder: (context) {
                return  AlertDialog(
                  title: const Text("Congratulation....!!! "),
                  content: const Text(''),
                  actions: [
                    TextButton(
                        child: const Text('Okay'),
                        onPressed: () {
                             Navigator.pushNamedAndRemoveUntil(context, Routes_Name.HomePage, (route) => false);
                        }),
                  ],
                );
              });*/
        } else if (loginProvider.loginData[0].status == "0") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Please Register in App"),
                  content: const Text(
                      'Your email id is not verified kindly register again with same details and verify your account to use app!'),
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

      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                  height: size.height / 2.5,
                  width: size.width,
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        controller: loginEmailIdController,
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          labelText: "Username",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username can't empty";
                          } else {
                            String emailExp =
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                            RegExp regExp = RegExp(emailExp);
                            if (regExp.hasMatch(value)) {
                            } else {
                              return "Please Enter Valid Email";
                            }
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
                          hintText: "Enter Password",
                          labelText: "Password",
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
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Routes_Name.ResetPasswordEmail);
                            },
                            child: const Text(
                              "Reset Password",
                              style: TextStyle(color: Colors.indigo),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: size.height / 50,
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
                            Navigator.pushNamed(
                                context, Routes_Name.SignUpScreen);
                          },
                          child: const Text("SignUp",
                              style: TextStyle(
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
