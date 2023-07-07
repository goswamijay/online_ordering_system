import 'package:flutter/material.dart';
import 'package:online_ordering_system/BlocCubit/BlocLoginScreen/BlocLoginScreen.dart';
import 'Widget/BlocSignTextField.dart';
import 'Widget/SignUpButtonWidget.dart';

class BlocSignupScreen extends StatefulWidget {
  const BlocSignupScreen({super.key});

  @override
  State<BlocSignupScreen> createState() => _BlocSignupScreenState();
}

final formKey = GlobalKey<FormState>();

bool passwordVisible = false;
String password1 = '';
TextEditingController signupNameController = TextEditingController();
TextEditingController signupMobileController = TextEditingController();
TextEditingController signupEmailController = TextEditingController();
TextEditingController signupPasswordController = TextEditingController();

class _BlocSignupScreenState extends State<BlocSignupScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                key: formKey,
                child: Column(
                  children: [
                    const BlocSignUpTextFiled(),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    const SignUpButtonWidget(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("You have an account? "),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return const BlocLoginScreen();
                            }));
                          },
                          child: const Text("Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink)),
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
