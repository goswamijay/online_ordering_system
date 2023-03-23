import 'package:flutter/material.dart';

import '../../../Utils/Routes_Name.dart';


class ResetPasswordEmail extends StatefulWidget {
  const ResetPasswordEmail({Key? key}) : super(key: key);

  @override
  State<ResetPasswordEmail> createState() => _ResetPasswordEmailState();
}

class _ResetPasswordEmailState extends State<ResetPasswordEmail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String name = "";

    final _formKey = GlobalKey<FormState>();
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
                key: _formKey,
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
