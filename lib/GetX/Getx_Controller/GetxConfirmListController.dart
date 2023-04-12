import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ConfirmListModelClass.dart';
import '../Getx_Models/GetxConfirmOrderModel.dart';
import 'package:http/http.dart' as http;

import '../Getx_Utils/Getx_Routes_Name.dart';

class GetxConfirmListController extends GetxController {
  RxList confirmData = [].obs;

  PlaceOrderModelClass placeOrderModelClass =
      PlaceOrderModelClass(status: 0, msg: '', data: []);
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    placeOrderAllDataAPI();
  }

  Future<void> getPlaceOrder(String cartId, String cartTotal) async {
    try {
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
        update();
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        update();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> placeOrderAllDataAPI() async {
    try {
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
        placeOrderModelClass = PlaceOrderModelClass.fromJson(jsonData);
        update();
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);
           isLoading.value = false;
        placeOrderModelClass = PlaceOrderModelClass.fromJson(jsonData);
        update();
      } else if (response.statusCode == 500) {
        Future.delayed(const Duration(seconds: 0), () async {
          Get.offAllNamed(GetxRoutes_Name.GetxLoginScreen);
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        });
      }
    } catch (error) {
      rethrow;
    }finally {
      isLoading.value = false;
    }
  }
}
