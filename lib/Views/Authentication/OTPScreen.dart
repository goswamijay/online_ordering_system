import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Map<String, dynamic>? argument = {};
  @override
  Widget build(BuildContext context) {
    argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        argument!['email_id'].toString(),
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
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        Routes_Name.HomePage, (route) => false);
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
