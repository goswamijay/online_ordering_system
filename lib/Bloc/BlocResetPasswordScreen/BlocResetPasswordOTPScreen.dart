import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:online_ordering_system/Bloc/BlocLoginScreen/BlocLoginScreen.dart';
import 'package:online_ordering_system/Bloc/BlocResetPasswordScreen/BlocResetPasswordCubit.dart';
import 'package:online_ordering_system/Bloc/BlocResetPasswordScreen/BlocResetPasswordState.dart';

class BlocResetPasswordOTPScreen extends StatelessWidget {
  const BlocResetPasswordOTPScreen({
    super.key,
    required this.email,
    required this.id,
  });
  final String email;
  final String id;

  @override
  Widget build(BuildContext context) {
    TextEditingController otp = TextEditingController();
    String verificationCode = '';
    int status = 0;
    Size size = MediaQuery.of(context).size;
    BlocResetPasswordCubit blocResetPasswordCubit =
        BlocProvider.of<BlocResetPasswordCubit>(context);

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
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        email.toString(),
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
                BlocConsumer<BlocResetPasswordCubit,
                    BlocResetPasswordScreenState>(builder: (builder, state) {
                  BlocResetPasswordCubit controller =
                      BlocProvider.of<BlocResetPasswordCubit>(context);
                  if (state is BlocResetPasswordLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  return OtpTextField(
                    numberOfFields: 4,
                    borderColor: const Color(0xFF512DA8),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},

                    onSubmit: (String code) {
                      verificationCode = code;
                      controller.forgetPasswordOTP(id, verificationCode);
                    }, // end onSubmit
                  );
                }, listener: (listener, state) {
                  if (state is BlocResetPasswordVerifiedSuccessfullyState) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                "${'Verification Code is Verified Successfully & New Password will send into your'} ${email.toString()} id."),
                            actions: [
                              TextButton(
                                  child: const Text('Okay'),
                                  onPressed: () {
                                    //Navigator.pushNamed(context, Routes_Name.ResetPasswordValue, arguments: {'id': list1[0].data.jwtToken});
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const BlocLoginScreen()),
                                      (route) => false,
                                    );
                                  }),
                            ],
                          );
                        });
                  } else if (state is BlocResetPasswordVerifiedFailState) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
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
                        });
                  }
                }),
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
                        if(state is BlocResetPasswordResendOTPLoadingState){
                          return const CircularProgressIndicator();
                        }
                        return InkWell(
                          onTap: () {
                            blocResetPasswordCubit.resentOTP(id);

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
