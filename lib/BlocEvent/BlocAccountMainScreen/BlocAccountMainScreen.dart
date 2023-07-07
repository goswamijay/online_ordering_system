import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Bloc_HomePage.dart';
import 'BlocAccountResetPasswordScreen.dart';

class BlocAccountMainScreen extends StatefulWidget {
  const BlocAccountMainScreen({super.key});

  @override
  State<BlocAccountMainScreen> createState() => _BlocAccountMainScreenState();
}

class _BlocAccountMainScreenState extends State<BlocAccountMainScreen> {
  String name = "";
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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(
              context, MaterialPageRoute(builder: (_) => const BlocHomePage()));
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                    height: size.height / 2,
                    width: size.width,
                    image: const AssetImage("assets/account.gif")),
                const Text(
                  'Account Details',
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
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: name0,
                          readOnly: true,
                          decoration: const InputDecoration(
                            hintText: 'User Name of user',
                            labelText: 'User Name of user',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: email0,
                          readOnly: true,
                          decoration: const InputDecoration(
                            hintText: 'Email Address of user',
                            labelText: 'Email Address of user',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: mobileNo0,
                          readOnly: true,
                          decoration: const InputDecoration(
                            hintText: 'Mobile No of user',
                            labelText: 'Mobile No of user',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Address of user',
                            labelText: 'Address of user',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Address of user can't empty";
                            } else if (value.length < 10) {
                              return "Address of user is not valid";
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
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      const Text('Account Details is update'),
                                  actions: [
                                    TextButton(
                                        child: const Text('Okay'),
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
                            color: Colors.deepPurple,
                            borderRadius:
                                BorderRadius.circular(changeButton ? 50 : 8),
                          ),
                          child: changeButton
                              ? const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Save The Data",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const BlocAccountResetPasswordScreen()));
                            },
                            child: const Text("Reset Password",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          InkWell(
                            onTap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.remove('fcmToken1');
                              await preferences.clear();
                              print('clear');

                              // Get.offAllNamed(GetxRoutes_Name.GetxLoginScreen);
                            },
                            child: const Icon(CupertinoIcons.square_arrow_left),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height / 20,
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
