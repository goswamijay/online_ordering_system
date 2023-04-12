import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import 'package:online_ordering_system/Models/SignupModelClass.dart';

import '../../../Getx_Controller/GetxAuthenticationController.dart';


class GetResetPasswordOTP extends StatefulWidget {
  const GetResetPasswordOTP({Key? key}) : super(key: key);

  @override
  State<GetResetPasswordOTP> createState() => _GetResetPasswordOTPState();

}

class _GetResetPasswordOTPState extends State<GetResetPasswordOTP> {
  final getSignUpOtpVerification1 = Get.put(GetAuthenticationController());

  TextEditingController otp = TextEditingController();
  Map<String, dynamic>? argument = {};
  List<SignupModelClass> list1 = [];
  String verificationCode = '';
  int status = 0;

  resetPasswordOTP(String userId, String otp) async {
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/verifyOtpOnRegister');
      var response = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          {"userId": userId, "otp": otp},
        ),
      );

      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        status = jsonData['status'];
      } else if (response.statusCode == 400) {
        status = jsonData['status'];
        print(status);
      }
    } catch (e) {
      return e;
    }
  }


  moveToHome(BuildContext context) async {
    await resetPasswordOTP(argument!['userId'],verificationCode.toString());
    Future.delayed(const Duration(seconds: 0), () {
      if (status == 1) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title:  Text("Verification Code is Verified Successfully & New Password will send into your ${argument!['email_id'].toString()} id."),
                actions: [
                  TextButton(
                      child: const Text('Okay'),
                      onPressed: () {
                        //Navigator.pushNamed(context, Routes_Name.ResetPasswordValue, arguments: {'id': list1[0].data.jwtToken});
                        Navigator.pushNamedAndRemoveUntil(
                            context, GetxRoutes_Name.GetxLoginScreen, (route) => false);
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
                      onCodeChanged: (String code) {},

                      onSubmit: (String code) {
                        verificationCode = code;
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
                            getSignUpOtpVerification1.resentOTP(  argument!['id'].toString().replaceAll('(', '').replaceAll(')', ''),);

                            ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Otp sent successfully! ",
                                  style: TextStyle(
                                      fontSize: 16),
                                ),
                                backgroundColor:
                                Colors.indigo,
                                duration:
                                Duration(seconds: 1),
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

