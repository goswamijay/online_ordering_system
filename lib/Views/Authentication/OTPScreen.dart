import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:online_ordering_system/Controller/ApiConnection/Authentication.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/LoginModelClass.dart';
import '../../Utils/Routes_Name.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String verificationCode = '';
  TextEditingController otp = TextEditingController();
  String signUpId = "";
  String signUpEmail = "";
  String signUpPassword = '';

  List<LoginModelClass> list = [];

  @override
  void initState() {
    value(context);
    // TODO: implement initState
    super.initState();
  }

  value(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    signUpId = prefs.getString('signUpId').toString();
    signUpEmail = prefs.getString('signUpEmail').toString();
    signUpPassword = prefs.getString('signUpPassword').toString();
    setState(() {});
  }

  moveToHome(BuildContext context) async {
    final otpProvider = Provider.of<Authentication>(context, listen: false);

    final prefs = await SharedPreferences.getInstance();
    signUpId = prefs.getString('signUpId').toString();
    signUpEmail = prefs.getString('signUpEmail').toString();
    print(signUpEmail);

    otpProvider.otpVerificationMain(
        signUpId.toString().replaceAll('(', '').replaceAll(')', ''),
        verificationCode.toString());

    Future.delayed(const Duration(seconds: 3), () {
      if (otpProvider.otpVerification[0].status == "1") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Verification Code is Verified Successfully"),
                actions: [
                  TextButton(
                      child: const Text('Okay'),
                      onPressed: () async {
                        await otpProvider.loginUser(
                            signUpEmail, signUpPassword);
                        await Future.delayed(const Duration(seconds: 0), () {
                          if (otpProvider.loginData[0].status == "1") {
                            Navigator.pushNamedAndRemoveUntil(context,
                                Routes_Name.HomePage, (route) => false);
                          } else {
                            Navigator.pushNamedAndRemoveUntil(context,
                                Routes_Name.LoginScreen, (route) => false);
                          }
                        });
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
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        signUpEmail.toString(),
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
                      onTap: () {
                        Authentication.resentOTP(
                          signUpId
                              .toString()
                              .replaceAll('(', '')
                              .replaceAll(')', ''),
                        );
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
