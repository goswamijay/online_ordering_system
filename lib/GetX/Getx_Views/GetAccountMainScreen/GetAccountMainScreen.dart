import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAccountMainScreen extends StatefulWidget {
  const GetAccountMainScreen({Key? key}) : super(key: key);

  @override
  State<GetAccountMainScreen> createState() => _GetAccountMainScreenState();
}

class _GetAccountMainScreenState extends State<GetAccountMainScreen> {
  static String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String name1 = '';
  String mobileNo = '';
  TextEditingController name0 = TextEditingController();
  TextEditingController email0 = TextEditingController();
  TextEditingController mobileNo0 = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    access(context);
  }

  @override
  void dispose(){
    super.dispose();
    name0.dispose();
    email0.dispose();
    mobileNo0.dispose();
  }


  access(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('LoginEmail').toString();
      email0.text = email;
      name1 = prefs.getString('LoginName').toString();
      name0.text = name1;
      mobileNo = prefs.getString('LoginMobileNo').toString();
      mobileNo0.text = mobileNo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                    height: Get.height / 2,
                    width: Get.width,
                    image: const AssetImage("assets/account.gif")),
                 Text(
                  'Account Details'.tr,
                  style:const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: name0,
                          readOnly: true,
                          decoration:  InputDecoration(
                            hintText: 'User Name of user'.tr,
                            labelText: 'User Name of user'.tr,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: email0,
                          readOnly: true,
                          decoration:  InputDecoration(
                            hintText: 'Email Address of user'.tr,
                            labelText: 'Email Address of user'.tr,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: mobileNo0,
                          readOnly: true,
                          decoration:  InputDecoration(
                            hintText: 'Mobile No of user'.tr,
                            labelText: 'Mobile No of user'.tr,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          decoration:  InputDecoration(
                            hintText: 'Address of user'.tr,
                            labelText: 'Address of user'.tr,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Address of user can't empty".tr;
                            } else if (value.length < 10) {
                              return "Address of user is not valid".tr;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 50,
                      ),
                      InkWell(
                        onTap: () => {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:  Text('Account Details is update'.tr),
                                  actions: [
                                    TextButton(
                                        child:  Text('Okay'.tr),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
                                  ],
                                );
                              })
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          height: 50,
                          width: changeButton ? 50 : 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            /*  shape: changeButton? BoxShape.circle : BoxShape.rectangle,*/
                            color: Colors.deepPurple,
                            borderRadius:
                            BorderRadius.circular(changeButton ? 50 : 8),
                          ),
                          child: changeButton
                              ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                              :  Text(
                            "Save The Data".tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, GetxRoutes_Name.GetxAccountResetPassword);
                            },
                            child:  Text("Reset Password".tr,
                                style:const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          InkWell(
                            onTap: () async {
                              SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                              await preferences.remove('fcmToken1');
                              await preferences.clear();
                              print('clear');

                              Get.offAllNamed(GetxRoutes_Name.GetxLoginScreen);
                            },
                            child: const Icon(CupertinoIcons.square_arrow_left),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height / 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}