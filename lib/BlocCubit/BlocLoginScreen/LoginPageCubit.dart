import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ModelClass/LoginModelClass.dart';
import 'LoginPageState.dart';


class LoginCubit extends Cubit<LoginState> {
  BlocLoginModelClass loginModelClass = BlocLoginModelClass(
      status: '',
      msg: '',
      data: BlocLoginData(
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

  LoginCubit() : super(LoginUserInitialState()){
  bool  passwordShow = false;
    passwordHide(passwordShow);
  }

    void getLoginUser(String email, String password) async {
      try {
        emit(LoginUserLoadingState());
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
          loginModelClass = BlocLoginModelClass.fromJson(jsonData);

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwtToken', loginModelClass.data.jwtToken);
          await prefs.setString('LoginEmail', loginModelClass.data.emailId);
          await prefs.setString('LoginName', loginModelClass.data.name);
          await prefs.setString(
              'LoginMobileNo', loginModelClass.data.mobileNo);
          await prefs.setBool('LogInBool', loginModelClass.status == "1");

          log(prefs.get('jwtToken').toString());
          log(prefs.get('LoginEmail').toString());
          log(prefs.get('LoginName').toString());
          log(prefs.get('LogInBool').toString());

          emit(LoginUserLoginState(
            loginModelClass.msg.toString()
          ));
        } else {
          final jsonData = json.decode(response.body);
          loginModelClass = BlocLoginModelClass.fromJson(jsonData);
          emit(LoginUserFailState(loginModelClass.msg.toString()));
        }
      } catch (error) {
        rethrow;
      }
    }

    void passwordShowing(bool passwordShow){
      passwordShow = true;
      emit(PasswordShowState(passwordShow));
    }

  void passwordHide(bool passwordShow){
    passwordShow = false;
    emit(PasswordHideState(passwordShow));
  }
  }

