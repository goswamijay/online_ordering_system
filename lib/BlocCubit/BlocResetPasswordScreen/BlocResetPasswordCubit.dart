import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:online_ordering_system/BlocCubit/BlocResetPasswordScreen/BlocResetPasswordState.dart';

class BlocResetPasswordCubit extends Cubit<BlocResetPasswordScreenState>{
  BlocResetPasswordCubit() : super(BlocResetPasswordEmailInitialState());

  String emailExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  String emailId = '';
  String userId = '';
  int status = 0;
  int status1 = 0;

  forgotPassword(String emailId) async {
    try {
      emit(BlocResetPasswordEmailLoadingState());
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
            "emailId": emailId,
          },
        ),
      );

      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(jsonData);
        emailId = jsonData['data']['emailId'];
        userId = jsonData['data']['_id'];
        status = jsonData['status'];
        emit(BlocResetPasswordEmailSentSuccessfullyState());
      } else if (response.statusCode == 400) {
        status = jsonData['status'];
        emit(BlocResetPasswordEmailSentFailState());

      }
    } catch (e) {
      return e;
    }
  }

  forgetPasswordOTP(String userId, String otp) async {
    try {
      emit(BlocResetPasswordLoadingState());
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/verifyOtpOnForgotPassword');
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
        status1 = jsonData['status'];
        emit(BlocResetPasswordVerifiedSuccessfullyState());
      } else if (response.statusCode == 400) {
        status1 = jsonData['status'];
        emit(BlocResetPasswordVerifiedFailState());
      }
    } catch (e) {
      return e;
    }
  }

  Future<void> resentOTP(String userId) async {
    try {
      emit(BlocResetPasswordResendOTPLoadingState());
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
        emit(BlocResetPasswordResendOTPSuccessfullyState());
      } else {
        final jsonData = json.decode(response.body.toString());
        log(jsonData);
        emit(BlocResetPasswordResendOTPFailState());
      }
    } catch (error) {
      rethrow;
    }
  }
}
