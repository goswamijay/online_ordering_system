import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:online_ordering_system/Models/LoginModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ResetPasswordOtpModelClass.dart';
import '../../Models/SignupModelClass.dart';

class Authentication extends ChangeNotifier {
  List<LoginModelClass> _loginData = [];
  List<LoginModelClass> get loginData => _loginData;

  List<SignupModelClass> _signUpData = [];
  List<SignupModelClass> get signUpData => _signUpData;
  List<SignupModelClass> _otpVerification = [];
  List<SignupModelClass> get otpVerification => _otpVerification;

  Future<void> loginUser(String email, String password) async {
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/login');
      var response = await http.post(uri,
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: jsonEncode(
            {"emailId": email, "password": password},
          ));
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        var loginList = <LoginModelClass>[];

        loginList = [
          LoginModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: LoginData(
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
              ))
        ];
        _loginData = loginList;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', loginData[0].data.jwtToken);
        await prefs.setString('LoginEmail', loginData[0].data.emailId);
        await prefs.setString('LoginName', loginData[0].data.name);
        await prefs.setString('LoginMobileNo', loginData[0].data.mobileNo);
        await prefs.setBool('LogInBool', loginData[0].status == "1");



        print(prefs.get('jwtToken'));
        print(prefs.get('LoginEmail'));
        print(prefs.get('LoginName'));
        print(prefs.get('LogInBool'));

        notifyListeners();
      } else {
        var loginList1 = <LoginModelClass>[];

        loginList1 = [
          LoginModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: LoginData(
                id: '',
                name: '',
                mobileNo: '',
                emailId: '',
                createdAt: '',
                updatedAt: '',
                v: '',
                jwtToken: '',
                fcmToken: '',
                status: '',
              ))
        ];
        _loginData = loginList1;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUpUser(
      String email, String password, String name, String mobileNo) async {
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/registerUser');
      var response = await http.post(uri,
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: jsonEncode(
            {
              "name": name,
              "mobileNo": mobileNo,
              "emailId": email,
              "password": password
            },
          ));
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        var signUpList = <SignupModelClass>[];

        signUpList = [
          SignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: SignUpData(
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
              ))
        ];
        _signUpData = signUpList;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList(
          'signUpData',
          signUpData.map((e) => e.toString()).toList(),
        );
        await prefs.setString('login1', signUpData[0].status);
        await prefs.setString('signUpId', signUpData[0].data.id);
        await prefs.setString('signUpEmail', signUpData[0].data.emailId);
        await prefs.setString('signUpPassword', password);

        // await prefs.setString('jwtToken', signUpData[0].data.fcmToken);

        notifyListeners();
      } else {
        var signUpList1 = <SignupModelClass>[];

        signUpList1 = [
          SignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: SignUpData(
                id: '',
                name: '',
                mobileNo: '',
                emailId: '',
                status: '',
                createdAt: '',
                updatedAt: '',
                v: '',
                jwtToken: '',
                fcmToken: '',
              ))
        ];
        _signUpData = signUpList1;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> otpVerificationMain(String userId, String otp) async {
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/verifyOtpOnRegister');
      var response = await http.post(uri,
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: jsonEncode(
            {"userId": userId, "otp": otp},
          ));
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        var otpVerificationData = <SignupModelClass>[];

        otpVerificationData = [
          SignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: SignUpData(
                id: jsonData['data']['_id'].toString(),
                name: jsonData['data']['name'].toString(),
                mobileNo: jsonData['data']['mobileNo'].toString(),
                emailId: jsonData['data']['emailId'],
                status: jsonData['data']['status'].toString(),
                createdAt: jsonData['data']['createdAt'].toString(),
                updatedAt: jsonData['data']['updatedAt'].toString(),
                v: jsonData['data']['__v'].toString(),
                jwtToken: '',
                fcmToken: '',
              ))
        ];
        _otpVerification = otpVerificationData;

      /*  final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'jwtToken', otpVerificationData[0].data.jwtToken);*/

        //await prefs.setString('login1', loginData[0].status);
        notifyListeners();
      } else {
        var otpVerificationData1 = <SignupModelClass>[];

        otpVerificationData1 = [
          SignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: SignUpData(
                id: '',
                name: '',
                mobileNo: '',
                emailId: '',
                createdAt: '',
                updatedAt: '',
                v: '',
                jwtToken: '',
                fcmToken: '',
                status: '',
              ))
        ];
        _otpVerification = otpVerificationData1;
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<SignupModelClass>> otpPasswordResetVerification(
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
          {"userId": userId, "otp": otp},
        ),
      );

      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        //Map<String, dynamic> newResponses = jsonDecode(response.body);
        log(json.decode(response.body));

        signUp = [
          SignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: SignUpData(
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
              ))
        ];
        return signUp;
      } else if (response.statusCode == 400) {
        signUp = [
          SignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: SignUpData(
                id: '',
                name: '',
                mobileNo: '',
                emailId: '',
                createdAt: '',
                updatedAt: '',
                v: '',
                jwtToken: '',
                fcmToken: '',
                status: '',
              ))
        ];
      }
    } catch (e) {
      log(e.toString());
    }
    return signUp;
  }

  static Future<List<ResetPasswordOtpModelClass>> resetPassword(
      String email) async {
    List<ResetPasswordOtpModelClass> forgotPassword = [];
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/forgotPassword');
      var response = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          {
            "emailId": email,
          },
        ),
      );

      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        //Map<String, dynamic> newResponses = jsonDecode(response.body);
        log(jsonData);

        forgotPassword = [
          ResetPasswordOtpModelClass(
              status: jsonData['status'] ?? 0,
              msg: jsonData['msg'],
              data: ResetPasswordOtpModelData(
                id: jsonData['data']['_id'].toString(),
                name: jsonData['data']['name'].toString(),
                mobileNo: jsonData['data']['mobileNo'].toString(),
                emailId: jsonData['data']['emailId'],
                status: jsonData['data']['status'] ?? 0,
                createdAt: jsonData['data']['createdAt'].toString(),
                updatedAt: jsonData['data']['updatedAt'].toString(),
                v: jsonData['data']['__v'] ?? 0,
                jwtToken: jsonData['data']['jwtToken'].toString(),
                fcmToken: jsonData['data']['fcmToken'].toString(),
              ))
        ];
        return forgotPassword;
      } else if (response.statusCode == 400) {
        forgotPassword = [
          ResetPasswordOtpModelClass(
              status: jsonData['status'] ?? 0,
              msg: jsonData['msg'],
              data: ResetPasswordOtpModelData(
                id: "",
                name: "",
                mobileNo: "",
                emailId: "",
                status: 0,
                createdAt: "",
                updatedAt: "",
                v: 0,
                jwtToken: "",
                fcmToken: "",
              ))
        ];
      }
    } catch (e) {
      log(e.toString());
    }
    return forgotPassword;
  }

  static Future<List<ResetPasswordOtpModelClass1>> resetPasswordValueChange(
      String jwtToken, String password) async {
    List<ResetPasswordOtpModelClass1> forgotPassword = [];
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/changePassword');
      var response = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken",
          "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          {"newPass": password, "confirmPass": password},
        ),
      );

      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        //Map<String, dynamic> newResponses = jsonDecode(response.body);
        log(json.decode(response.body));

        forgotPassword = [
          ResetPasswordOtpModelClass1(
            status: jsonData['status'].toString(),
            msg: jsonData['msg'],
          )
        ];
        return forgotPassword;
      } else if (response.statusCode == 400) {
        forgotPassword = [
          ResetPasswordOtpModelClass1(
            status: jsonData['status'].toString(),
            msg: jsonData['msg'],
          )
        ];
      }
    } catch (e) {
      log (e.toString());
    }
    return forgotPassword;
  }


 static Future<void> resentOTP(String userId) async {
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/resendOtp');
      var response = await http.post(uri,
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: jsonEncode(
            {"userId": userId,},
          ));
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
      } else {
        final jsonData = json.decode(response.body);
        print(jsonData);
      }
    } catch (error) {
      rethrow;
    }
  }
}
