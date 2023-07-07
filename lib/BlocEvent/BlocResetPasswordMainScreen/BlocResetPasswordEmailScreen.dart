import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/BlocResetPasswordMainBloc.dart';
import 'Bloc/BlocResetPasswordMainEvent.dart';
import 'Bloc/BlocResetPasswordMainState.dart';
import 'BlocResetPasswordOTPScreen.dart';

class BlocResetPasswordEmailScreen extends StatelessWidget {
  const BlocResetPasswordEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController resetPasswordEmailController =
        TextEditingController();

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
                "Email ID",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(
                        controller: resetPasswordEmailController,
                        decoration: const InputDecoration(
                          hintText: "Enter Register Email ID",
                          labelText: "Enter Register Email ID",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email ID can't empty";
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
                    SizedBox(
                      height: size.height / 50,
                    ),
                    BlocConsumer<BlocResetPasswordMainBloc,
                        BlocResetPasswordMainState>(
                      builder: (builder, state) {
                        BlocResetPasswordMainBloc controller =
                            BlocProvider.of<BlocResetPasswordMainBloc>(context);
                        if (state is BlocResetPasswordEmailLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        return InkWell(
                          onTap: () {
                            controller.add(BlocForgetPasswordEvent(
                                resetPasswordEmailController.text));
                          },
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            height: 50,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              /*  shape: changeButton? BoxShape.circle : BoxShape.rectangle,*/
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Forget Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        );
                      },
                      listener: (listener, state) {
                        BlocResetPasswordMainBloc controller =
                            BlocProvider.of<BlocResetPasswordMainBloc>(context);

                        if (state
                            is BlocResetPasswordEmailSentSuccessfullyState) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                      "Verification Code is send Successfully"),
                                  actions: [
                                    TextButton(
                                        child: const Text('Okay'),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      BlocResetPasswordOTPScreen(
                                                          email:
                                                              resetPasswordEmailController
                                                                  .text,
                                                          id: controller
                                                              .userId)));
                                        }),
                                  ],
                                );
                              });
                        } else if (state
                            is BlocResetPasswordEmailSentFailState) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                      "This Email Id is not Registered With us kindly register first!"),
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
