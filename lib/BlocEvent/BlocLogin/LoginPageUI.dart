import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BlocResetPasswordMainScreen/BlocResetPasswordEmailScreen.dart';
import '../BlocSignUpPage/signUpPage.dart';
import '../Bloc_HomePage.dart';
import 'Bloc/LoginPageEvent.dart';
import 'Bloc/LoginPageState.dart';
import 'Bloc/loginpage_bloc.dart';

class BlocLoginScreen extends StatefulWidget {
  const BlocLoginScreen({super.key});

  @override
  State<BlocLoginScreen> createState() => _BlocLoginScreenState();
}

GlobalKey<FormState> loginKey = GlobalKey<FormState>();
TextEditingController loginEmailIdController = TextEditingController();
TextEditingController loginPasswordIdController = TextEditingController();

bool passwordVisible = false;

class _BlocLoginScreenState extends State<BlocLoginScreen> {
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
                key: loginKey,
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
                      ),
                    ),
                    BlocConsumer<LoginBloc, LoginState>(
                      bloc: BlocProvider.of<LoginBloc>(context),
                      listener: (context, state) {
                        if (state is PasswordShowState) {
                          passwordVisible = state.passwordVisible;
                          print(passwordVisible);
                        } else if (state is PasswordHideState) {
                          passwordVisible = state.passwordHide;
                          print(passwordVisible);
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: TextFormField(
                            controller: loginPasswordIdController,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                      LoginPasswordShowEvent(passwordVisible));

                                  print(state);
                                },
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              hintText: "Enter Password",
                              labelText: "Password",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password can't be empty";
                              } else if (value.length < 6) {
                                return "Password is less than 6 characters";
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      const BlocResetPasswordEmailScreen()));
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
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (BuildContext context, state) {
                        if (state is LoginUserLoginState) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.loginStateMessage)));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const BlocHomePage()),
                            (route) => false,
                          );
                        } else if (state is LoginUserFailState) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.loginFailStateError)));
                        }
                      },
                      builder: (BuildContext context, state) {
                        if (state is LoginUserLoadingState) {
                          return const CircularProgressIndicator();
                        }

                        return InkWell(
                          onTap: () {
                            try {
                              if (loginKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                    LoginUserLoginEvent(
                                        loginEmailIdController.text,
                                        loginPasswordIdController.text));
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            height: 50,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return const BlocSignupScreen();
                            }));
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
