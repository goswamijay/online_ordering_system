import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/Bloc/BlocAccountMainScreen/BlocAccountResetPasswordState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlocAccountResetPasswordCubit extends Cubit<BlocAccountResetPasswordState> {
  BlocAccountResetPasswordCubit()
      : super(BlocAccountResetPasswordInitialState());

  resetPassword(String password) async {
    emit(BlocAccountResetPasswordLoadingState());
    final prefs = await SharedPreferences.getInstance();

    final jwtToken1 = prefs.getString('jwtToken'.toString());
    try {
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/changePassword');
      var response = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken1",
          "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          {"newPass": password, "confirmPass": password},
        ),
      );

      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        emit(BlocAccountResetPasswordChangeSuccessfullyState());

      } else if (response.statusCode == 400) {
        emit(BlocAccountResetPasswordChangeFailState());

      }
    } catch (e) {
      return e;
    }
  }
}