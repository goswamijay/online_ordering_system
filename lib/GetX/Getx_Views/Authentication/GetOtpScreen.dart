import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Getx_Controller/GetxAuthenticationController.dart';
import '../../Getx_Utils/Getx_Routes_Name.dart';

class GetOtpScreen extends StatefulWidget {
  const GetOtpScreen({Key? key}) : super(key: key);

  @override
  State<GetOtpScreen> createState() => _GetOtpScreenState();
}

class _GetOtpScreenState extends State<GetOtpScreen> {
  final getSignUpOtpVerification1 = Get.put(GetAuthenticationController());

  String verificationCode = '';
  TextEditingController otp = TextEditingController();
  String signUpId = "";
  String signUpEmail = "";
  String signUpPassword = '';
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    signUpId = prefs.getString('signUpId').toString();
    signUpEmail = prefs.getString('signUpEmail').toString();
    signUpPassword = prefs.getString('signUpPassword').toString();
    setState(() {

    });
  }

  moveToHome(BuildContext context) async {
    await getSignUpOtpVerification1.getSignUpOtpVerification(
        signUpId.toString().replaceAll('(', '').replaceAll(')', ''),
        verificationCode.toString());

    Future.delayed(const Duration(seconds: 0), () {
      if (getSignUpOtpVerification1.getSignupModelClass.status == "1") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Verification Code is Verified Successfully"),
                actions: [
                  TextButton(
                      child: const Text('Okay'),
                      onPressed: () async {
                        await getSignUpOtpVerification1.getLoginUser(
                            signUpEmail, signUpPassword);
                        await Future.delayed(const Duration(seconds: 0), () {
                          if (getSignUpOtpVerification1.getLoginModelClass.status == "1") {
                            Navigator.pushNamedAndRemoveUntil(context,
                                GetxRoutes_Name.GetxHomePage, (route) => false);
                          } else {
                            Navigator.pushNamedAndRemoveUntil(context,
                                GetxRoutes_Name.GetxLoginScreen, (route) => false);
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
                  height: Get.height / 2.5,
                  width: Get.width,
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                const Text(
                  "OTP Verification",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: Get.height / 30,
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
                            Get.back();
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  )
                ]),
                SizedBox(
                  height: Get.height / 30,
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
                    moveToHome(context);
                  }, // end onSubmit
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't Receive the OTP? "),
                    InkWell(
                      onTap: () {
                        getSignUpOtpVerification1.resentOTP(
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
