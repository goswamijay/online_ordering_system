import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/Bloc/BlocAccountMainScreen/BlocAccountResetPasswordCubit.dart';
import 'package:online_ordering_system/Bloc/BlocAccountMainScreen/BlocAccountResetPasswordState.dart';
import 'package:online_ordering_system/Bloc/BlocLoginScreen/BlocLoginScreen.dart';

class BlocAccountResetPasswordScreen extends StatefulWidget {
  const BlocAccountResetPasswordScreen({super.key});

  @override
  State<BlocAccountResetPasswordScreen> createState() =>
      _BlocAccountResetPasswordScreenState();
}

class _BlocAccountResetPasswordScreenState
    extends State<BlocAccountResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  TextEditingController verificationCodeController = TextEditingController();

  static String name = "";
  bool changeButton = false;
  int status = 0;

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
                'Reset Password',
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        controller: verificationCodeController,
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
                    BlocConsumer<BlocAccountResetPasswordCubit,
                        BlocAccountResetPasswordState>(
                      builder: (context, state) {
                        if(state is BlocAccountResetPasswordLoadingState){
                          return const CircularProgressIndicator();
                        }
                        return InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              BlocProvider.of<BlocAccountResetPasswordCubit>(context)
                                  .resetPassword(verificationCodeController.text);
                            }
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
                        );
                      },
                      listener: (listener, state) {
                        if(state is BlocAccountResetPasswordChangeSuccessfullyState){
                          Future.delayed(const Duration(seconds: 0), () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Your password has been changed successfully,Please login again!'),
                                      actions: [
                                        TextButton(
                                            child: const Text('Okay'),
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(builder: (context) => const BlocLoginScreen()),
                                                    (route) => false,
                                              );
                                            }),
                                      ],
                                    );
                                  });
                            }
                          );
                        }else if(state is BlocAccountResetPasswordChangeFailState){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Verification Code is Not Correct'),
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
                      },
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
