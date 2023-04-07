import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ConfirmListModelClass.dart';
import 'package:http/http.dart' as http;

class PlaceOrderProvider with ChangeNotifier {
   PlaceOrderModelClass _confirmList = PlaceOrderModelClass(
    status: 0,
    msg: '',
    data: []
  );

  PlaceOrderModelClass get confirmList => _confirmList;
  bool showItemBool = false;

   showItem(){
     showItemBool = true;
     notifyListeners();
   }

  Future<void> placeOrderAllDataAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
      final jwtToken0 = prefs.getString('jwtToken');

      log(jwtToken1.toString());

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/order/getOrderHistory');
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Authorization':' Bearer ${jwtToken1.toString()}',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final placeData = PlaceOrderModelClass.fromJson(jsonData);

        _confirmList = placeData;
        log(jsonData.toString());
        notifyListeners();
      } else {

        final placeData = PlaceOrderModelClass.fromJson(jsonData);

        _confirmList = placeData;
      }
    } catch (error) {
      rethrow;
    }
  }


  Future<void> placeOrder(String cartId, String cartTotal) async {
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

        notifyListeners();
      } else {
        final jsonData = json.decode(response.body);

          log(jsonData.toString());

        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }
}
