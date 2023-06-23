import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:online_ordering_system/Bloc/BlocOTPScreen/OtpScreenCubit.dart';
import 'package:online_ordering_system/Bloc/BlocOTPScreen/OtpScreenState.dart';

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
                            //size.back();
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  )
                ]),
                SizedBox(
                  height: size.height / 30,
                ),
                BlocConsumer<OtpScreenCubit, OtpScreenState>(
                    listener: (BuildContext context, state) {
                  if (state is OtpVerifiedSuccessfullyState) {
                    AlertDialog(
                      title: const Text(
                          "Verification Code is Verified Successfully"),
                      actions: [
                        TextButton(
                            child: const Text('Okay'), onPressed: () async {}),
                      ],
                    );
                  } else if (state is OtpVerifiedFailedState) {
                    AlertDialog(
                      title: const Text("Verification Code is Not Current"),
                      actions: [
                        TextButton(
                            child: const Text('Okay'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ],
                    );
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
                      BlocProvider.of<OtpScreenCubit>(context).getSignUpOtpVerification(widget.signUpId,verificationCode);
                      // moveToHome(context);
                    }, // end onSubmit
                  );
                }),
                SizedBox(
                  height: size.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't Receive the OTP? "),
                    InkWell(
                      onTap: () {
                        // getSignUpOtpVerification1.resentOTP(
                        //   signUpId
                        //       .toString()
                        //       .replaceAll('(', '')
                        //       .replaceAll(')', ''),
                        // );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Otp sent successfully! ",
                              style: TextStyle(fontSize: 16),
                            ),
                            backgroundColor: Colors.indigo,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text(
                        "RESEND OTP",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.pink),
                      ),
                    ),
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
