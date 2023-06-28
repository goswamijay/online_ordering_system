import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/Bloc/BlocOrderPlaceMainScreen/BlocOrderPlaceScreenState.dart';
import 'package:online_ordering_system/Bloc/ModelClass/BlocOrderPlaceModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlocOrderPlaceScreenCubit extends Cubit<BlocOrderPlaceScreenState> {
  BlocOrderPlaceScreenCubit() : super(BlocOrderPlaceInitialState());
  BlocPlaceOrderModelClass placeOrderModelClass =
      BlocPlaceOrderModelClass(status: 0, msg: '', data: []);

  Future<void> getPlaceOrder(String cartId, String cartTotal) async {
    try {
      emit(BlocOrderPlaceAddLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/order/placeOrder');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartId": cartId,
        'cartTotal': cartTotal
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocOrderPlaceAddSuccessfullyState());
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocOrderPlaceAddFailState());
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> placeOrderAllDataAPI() async {
    try {
      emit(BlocOrderPlaceGetLoadingState());

      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      log(jwtToken1.toString());

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/order/getOrderHistory');
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Authorization': ' Bearer ${jwtToken1.toString()}',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        placeOrderModelClass = BlocPlaceOrderModelClass.fromJson(jsonData);
        emit(BlocOrderPlaceGetSuccessfullyState());
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);
        placeOrderModelClass = BlocPlaceOrderModelClass.fromJson(jsonData);
        emit(BlocOrderPlaceGetFailState());
      } else if (response.statusCode == 500) {
        Future.delayed(const Duration(seconds: 0), () async {
          emit(BlocOrderPlaceJWTTokenNotFoundState());
          // Get.offAllNamed(GetxRoutes_Name.GetxLoginScreen);
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        });
      }
    } catch (error) {
      rethrow;
    }
  }
}
