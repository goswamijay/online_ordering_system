import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';

import '../../Controller/ApiConnection/Authentication.dart';
import '../../Models/SignupModelClass.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Map<String, dynamic>? argument = {};
  List<SignupModelClass> list1 = [];
  String verificationCode = '';
  TextEditingController otp = TextEditingController();

  moveToHome(BuildContext context) async {
    accessApi();
    Future.delayed(const Duration(seconds: 3), () {
      if (list1[0].status == "1") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Verification Code is Verified Successfully"),
                actions: [
                  TextButton(
                      child: const Text('Okay'),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes_Name.HomePage, (route) => false);
                      }),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Verification Code is Not Current"),
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
    });
  }

  void accessApi() async {
    //  String id = list.map((e) => e.data.id).toString();
    await Future.delayed(const Duration(seconds: 1), () async {
      print( argument!['id'].toString().replaceAll('(', '').replaceAll(')', ''));
      list1 = await Authentication.otpVerification(
          argument!['id'].toString().replaceAll('(', '').replaceAll(')', ''), verificationCode.toString());
    });
  }

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
                  numberOfFields: 4,
                  borderColor: const Color(0xFF512DA8),
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    verificationCode = code;
                  },
                  onSubmit: (String code) {
                    verificationCode = code;
                    print(verificationCode);
                    moveToHome(context);
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
