import 'package:flutter/material.dart';

import '../../../Utils/Routes_Name.dart';


class ResetPasswordEmail extends StatefulWidget {
  const ResetPasswordEmail({Key? key}) : super(key: key);

  @override
  State<ResetPasswordEmail> createState() => _ResetPasswordEmailState();
}

class _ResetPasswordEmailState extends State<ResetPasswordEmail> {

/*
  Future<List<SignupModelClass>> otpVerification(
      String userId, String otp) async {
    List<SignupModelClass> signUp = [];
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
          {
            "userId": userId,
            "otp": otp
          },
        ),
      );

      print(response.statusCode == 400);
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        //Map<String, dynamic> newResponses = jsonDecode(response.body);
        print(json.decode(response.body));

        signUp = [
          SignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data:
              SignUpData(
                id: jsonData['data']['_id'].toString(),
                name: jsonData['data']['name'].toString(),
                mobileNo: jsonData['data']['mobileNo'].toString(),
                emailId: jsonData['data']['emailId'],
                status: jsonData['data']['status'].toString(),
                createdAt: jsonData['data']['createdAt'].toString(),
                updatedAt: jsonData['data']['updatedAt'].toString(),
                v: jsonData['data']['__v'].toString(),
                jwtToken: jsonData['data']['jwtToken'].toString(),
                fcmToken: jsonData['data']['fcmToken'].toString(),
              )
          )
        ];
        return signUp;
      } else if(response.statusCode == 400){
        signUp = [
          SignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data:
              SignUpData(
                id: jsonData['data']['_id'].toString(),
                name: jsonData['data']['name'].toString(),
                mobileNo: jsonData['data']['mobileNo'].toString(),
                emailId: jsonData['data']['emailId'],
                status: jsonData['data']['status'].toString(),
                createdAt: jsonData['data']['createdAt'].toString(),
                updatedAt: jsonData['data']['updatedAt'].toString(),
                v: jsonData['data']['__v'].toString(),
                jwtToken: jsonData['data']['jwtToken'].toString(),
                fcmToken: jsonData['data']['fcmToken'].toString(),
              )
          )
        ];
      }
    } catch (e) {
      print(e.toString());
    }
    return signUp;
  }*/
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String name = "";

    final formKey = GlobalKey<FormState>();
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
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter Register Email ID",
                          labelText: "Enter Register Email ID",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email ID can't empty";
                          } else if (value.length < 10 || value.length > 10) {
                            return "Mobile number is not valid";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),

                    SizedBox(
                      height: size.height / 50,
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushNamed(context,Routes_Name.ResetPasswordOTP  ,arguments: {'email_id': name.toString()})
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: 50,
                        width:  150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          /*  shape: changeButton? BoxShape.circle : BoxShape.rectangle,*/
                          color: Colors.deepPurple,
                          borderRadius:
                          BorderRadius.circular(8),
                        ),
                        child:  const Text(
                          "Save The Data",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
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
