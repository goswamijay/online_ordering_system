import 'package:flutter/material.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({Key? key}) : super(key: key);

  @override
  State<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends State<SignUPPage> {
  static String name = "";
  static String Email = "";
  static String Password1 = "";
  static String Confirm_Password = "";
  bool changeButton = false;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      _formKey.currentState!.save();
      print(Email);

      await Future.delayed(const Duration(seconds: 1));
      //await Navigator.pushNamed(context, Routes_Name.OTPScreen);
      Navigator.pushNamed(context, Routes_Name.OTPScreen, arguments: {'email_id': Email.toString()});

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
                  height: size.height / 2.7,
                  width: size.width,
                  image: const AssetImage("assets/signup.png")),
              const Text(
                "Welcome",
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
                        decoration: const InputDecoration(
                          hintText: "User Name",
                          labelText: "User Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "User Name can't empty";
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
                        decoration: const InputDecoration(
                          hintText: "Email Id",
                          labelText: "Email Id",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Id can't empty";
                          }
                        },
                        onChanged: (value) {
                          Email = value;
                          print(Email);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
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
                          Password1 = value;
                          print(Password1);
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
                          } else if (value != Password1) {
                            return "Password not matched";
                          }
                        },
                        onChanged: (value) {
                          Confirm_Password = value;
                          print(Confirm_Password);
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
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
                                "Sign UP",
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
                        const Text("You have an account? "),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes_Name.LoginScreen);
                          },
                          child: const Text("LogIn",
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
