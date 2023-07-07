import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:online_ordering_system/BlocCubit/BlocLoginScreen/LoginPageState.dart';
import 'package:online_ordering_system/BlocCubit/BlocOTPScreen/OtpScreenCubit.dart';
import 'package:online_ordering_system/BlocCubit/BlocOTPScreen/OtpScreenState.dart';

import '../BlocLoginScreen/LoginPageCubit.dart';
import '../BlocResetPasswordScreen/BlocResetPasswordCubit.dart';
import '../BlocResetPasswordScreen/BlocResetPasswordState.dart';

class BlocOTPScreen extends StatefulWidget {
  final String signUpId;
  final String signUpEmail;
  final String signUpPassword;
  const BlocOTPScreen(
      {super.key,
      required this.signUpId,
      required this.signUpEmail,
      required this.signUpPassword});

  @override
  State<BlocOTPScreen> createState() => _BlocOTPScreenState();
}

class _BlocOTPScreenState extends State<BlocOTPScreen> {
  String verificationCode = '';
  TextEditingController otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
              children: [
                Image.asset(
                  'assets/otp.png',
                  height: size.height / 2.5,
                  width: size.width,
                ),
                SizedBox(
                  height: size.height / 20,
                ),
                const Text(
                  "OTP Verification",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Enter the OTP sent to:-"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.signUpEmail.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  )
                ]),
                SizedBox(
                  height: size.height / 30,
                ),
                BlocConsumer<LoginCubit, LoginState>(
                    builder: (builder, state) {
                      return BlocConsumer<OtpScreenCubit, OtpScreenState>(
                          listener: (BuildContext context, state) {
                        if (state is OtpVerifiedSuccessfullyState) {
                          AlertDialog(
                            title: const Text(
                                "Verification Code is Verified Successfully"),
                            actions: [
                              TextButton(
                                  child: const Text('Okay'),
                                  onPressed: () async {}),
                            ],
                          );
                        } else if (state is OtpVerifiedFailedState) {
                          AlertDialog(
                            title:
                                const Text("Verification Code is Not Current"),
                            actions: [
                              TextButton(
                                  child: const Text('Okay'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ],
                          );
                        } else if (state is OtpVerifiedLoadingState) {
                          BlocProvider.of<LoginCubit>(context).getLoginUser(
                              widget.signUpEmail, widget.signUpPassword);
                        }
                      }, builder: (BuildContext context, state) {
                        if (state is OtpLoadingState) {
                          return const CircularProgressIndicator();
                        }

                        return OtpTextField(
                          numberOfFields: 4,
                          borderColor: const Color(0xFF512DA8),
                          showFieldAsBox: true,
                          onCodeChanged: (String code) {
                            verificationCode = code;
                          },
                          onSubmit: (String code) {
                            verificationCode = code;
                            print(verificationCode);
                            BlocProvider.of<OtpScreenCubit>(context)
                                .getSignUpOtpVerification(
                                    widget.signUpId, verificationCode);
                            // moveToHome(context);
                          }, // end onSubmit
                        );
                      });
                    },
                    listener: (listener, state) {}),
                SizedBox(
                  height: size.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't Receive the OTP? "),
                    BlocConsumer<BlocResetPasswordCubit,
                        BlocResetPasswordScreenState>(
                      builder: (builder, state) {
                        BlocResetPasswordCubit blocResetPasswordCubit =
                        BlocProvider.of<BlocResetPasswordCubit>(context);
                        if(state is BlocResetPasswordResendOTPLoadingState){
                          return const CircularProgressIndicator();
                        }
                        return InkWell(
                          onTap: () {
                            blocResetPasswordCubit.resentOTP(widget.signUpId);

                          },
                          child: const Text(
                            "RESEND OTP",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          ),
                        );
                      },
                      listener: (listener, state) {
                        if(state is BlocResetPasswordResendOTPSuccessfullyState){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Verification Code is send Successfully"),
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
                    )
                  ],
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
