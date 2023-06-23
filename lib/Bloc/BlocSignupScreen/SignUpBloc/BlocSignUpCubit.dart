import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/Bloc/ModelClass/BlocSignUpClass.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'BlocSignupState.dart';

class BlocSignUpCubit extends Cubit<SignUpState> {
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
  BlocSignUpCubit() : super(SignUpUserInitialState()) {
    bool passwordShow = false;
    passwordHide(passwordShow);
  }

  Future<void> getSignUpUser(
      String email, String password, String name, String mobileNo) async {
    try {
      emit(SignUpUserLoadingState());
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
              "password": password,


            },
          ));
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        blocSignupModelClass = BlocSignupModelClass.fromJson(jsonData);

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('login1', blocSignupModelClass.status);
        await prefs.setString('signUpId', blocSignupModelClass.data.id);
        await prefs.setString('signUpEmail', blocSignupModelClass.data.emailId);
        await prefs.setString('signUpPassword', password);
        emit(SignUpUserState(blocSignupModelClass.msg.toString()));
      } else {
        final jsonData = json.decode(response.body);
        blocSignupModelClass = BlocSignupModelClass.fromJson(jsonData);
        emit(SignUpUserFailState(blocSignupModelClass.msg.toString()));
      }
    } catch (error) {
      rethrow;
    }
  }

  void passwordShowing(bool passwordShow) {
    passwordShow = true;
    emit(PasswordShowSignUpState(passwordShow));
  }

  void passwordHide(bool passwordShow) {
    passwordShow = false;
    emit(PasswordHideSignUpState(passwordShow));
  }
}
