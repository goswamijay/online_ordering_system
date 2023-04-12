import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Models/GetSignupModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Getx_Models/GetxLoginModelClass.dart';
import 'package:http/http.dart' as http;

class GetAuthenticationController extends GetxController {
  GetLoginModelClass getLoginModelClass = GetLoginModelClass(
      status: '',
      msg: '',
      data: GetLoginData(
          id: '',
          name: '',
          mobileNo: '',
          emailId: '',
          status: '',
          jwtToken: '',
          fcmToken: '',
          createdAt: '',
          updatedAt: '',
          v: ''));

  GetSignupModelClass getSignupModelClass = GetSignupModelClass(
      status: '',
      msg: '',
      data: GetSignUpData(
          id: '',
          name: '',
          mobileNo: '',
          emailId: '',
          status: '',
          jwtToken: '',
          fcmToken: '',
          createdAt: '',
          updatedAt: '',
          v: ''));

  Future<void> getLoginUser(String email, String password) async {
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
        getLoginModelClass = GetLoginModelClass.fromJson(jsonData);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', getLoginModelClass.data.jwtToken);
        await prefs.setString('LoginEmail', getLoginModelClass.data.emailId);
        await prefs.setString('LoginName', getLoginModelClass.data.name);
        await prefs.setString(
            'LoginMobileNo', getLoginModelClass.data.mobileNo);
        await prefs.setBool('LogInBool', getLoginModelClass.status == "1");

        log(prefs.get('jwtToken').toString());
        log(prefs.get('LoginEmail').toString());
        log(prefs.get('LoginName').toString());
        log(prefs.get('LogInBool').toString());

        update();
      } else {
        final jsonData = json.decode(response.body);
        getLoginModelClass = GetLoginModelClass.fromJson(jsonData);
        update();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getSignUpUser(
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
        getSignupModelClass = GetSignupModelClass.fromJson(jsonData);

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('login1', getSignupModelClass.status);
        await prefs.setString('signUpId', getSignupModelClass.data.id);
        await prefs.setString('signUpEmail', getSignupModelClass.data.emailId);
        await prefs.setString('signUpPassword', password);

        update();
      } else {
        final jsonData = json.decode(response.body);
        getSignupModelClass = GetSignupModelClass.fromJson(jsonData);
        update();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getSignUpOtpVerification(String userId, String otp) async {
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
        getSignupModelClass = GetSignupModelClass.fromJson(jsonData);
        update();
      } else {
        final jsonData = json.decode(response.body);
        getSignupModelClass = GetSignupModelClass.fromJson(jsonData);
      }
    } catch (error) {
      rethrow;
    }
  }
  Future<void> resentOTP(String userId) async {
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
        final jsonData = json.decode(response.body.toString());
        log(jsonData['status'].toString());
        update();
      } else {
        final jsonData = json.decode(response.body.toString());
        log(jsonData);
      }
    } catch (error) {
      rethrow;
    }
  }
   Future<List<GetSignupModelClass>> otpPasswordResetVerification(
      String userId, String otp) async {
    List<GetSignupModelClass> signUp = [];
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
          GetSignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: GetSignUpData(
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
          GetSignupModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data: GetSignUpData(
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


}

