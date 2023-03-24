import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_ordering_system/Models/LoginModelClass.dart';

import '../../Models/SignupModelClass.dart';

class Authentication {
  static Future<List<SignupModelClass>> signUpUser(
      String email, String password, String name, String mobileNo) async {
    List<SignupModelClass> signUp = [];
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/registerUser');
      var response = await http.post(
        uri,
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
        ),
      );

      print(response.statusCode == 201);
      var jsonData = json.decode(response.body);

      if (response.statusCode == 201) {
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
      }
    } catch (e) {
      print(e.toString());
    }
    return signUp;
  }


  static Future<List<SignupModelClass>> otpVerification(
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
  }


  static Future<List<LoginModelClass>> logInUser(
      String email, String password) async {
    List<LoginModelClass> Login = [];
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/login');
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
            "password": password
          },
        ),
      );

      print(response.statusCode == 400);
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        //Map<String, dynamic> newResponses = jsonDecode(response.body);
        print(json.decode(response.body));

        Login = [
          LoginModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data:
              LoginData(
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
        return Login;
      } else if(response.statusCode == 400){
        Login = [
          LoginModelClass(
              status: jsonData['status'].toString(),
              msg: jsonData['msg'],
              data:
              LoginData(
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
    return Login;
  }
}
