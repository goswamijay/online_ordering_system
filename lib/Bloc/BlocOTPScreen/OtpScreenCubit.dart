import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/Bloc/BlocOTPScreen/OtpScreenState.dart';
import 'package:http/http.dart' as http;

import '../ModelClass/BlocSignUpClass.dart';

class OtpScreenCubit extends Cubit<OtpScreenState> {
  BlocSignupModelClass blocSignupModelClass = BlocSignupModelClass(
      status: '',
      msg: '',
      data: BlocSignUpData(
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
  OtpScreenCubit() : super(OtpInitialState());

  void getSignUpOtpVerification(String userId, String otp) async {
    emit(OtpLoadingState());
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
        blocSignupModelClass = BlocSignupModelClass.fromJson(jsonData);
        emit(OtpVerifiedSuccessfullyState());
        emit(OtpVerifiedLoadingState());

      } else {
        final jsonData = json.decode(response.body);
        blocSignupModelClass = BlocSignupModelClass.fromJson(jsonData);
        emit(OtpVerifiedFailedState());
      }
    } catch (error) {
      rethrow;
    }
  }
}
