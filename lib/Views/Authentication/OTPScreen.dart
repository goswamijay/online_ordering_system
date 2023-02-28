import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Map<String,dynamic> argument = {};
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 0),(){
       argument = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    });
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                  children: [
                    const Text(
                      "OTP Verification",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Enter the OTP sent to:-"),
                       Text(
                        argument['email_id'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                    ]),
                    OtpTextField(
                      numberOfFields: 6,
                      borderColor: const Color(0xFF512DA8),
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {},

                      onSubmit: (String verificationCode) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Verification Code"),
                                content: Text('Code entered is $verificationCode'),
                                actions: [
                                  TextButton(
                                      child: const Text('Okay'),
                                      onPressed: () {
                                        Navigator.pushNamed(context, Routes_Name.HomePage);
                                      }),
                                ],
                              );
                            });
                      }, // end onSubmit
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Didn't Receive the OTP? "),
                        InkWell(
                          onTap: () {},
                          child: const Text("RESEND OTP",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink),),
                        ),
                      ],
                    ),
                    Image.asset(
                      'otp.png',
                      height: size.height / 1.5,
                      width: size.width / 1.5,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}