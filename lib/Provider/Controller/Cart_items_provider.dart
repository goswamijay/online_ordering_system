import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/CartAddItemModelClass.dart';
import '../Models/FavoriteListModelClass.dart';
import '../Utils/Routes_Name.dart';

class cart_items_provider with ChangeNotifier {
  List<FavoriteListModelClass> _purchaseList = [];
  List<dynamic> get purchaseList => _purchaseList;
  List<CartAddItemModelClass> _addCartItem = [];
  List<dynamic> get addCartItem => _addCartItem;

  bool showItemBool = false;
  bool itemAdded = false;

  showItem(){
    showItemBool = true;
    notifyListeners();
  }


  Future<void> productAllAPI(String productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/addToCart');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "productId": productId,
      });
      if (response.statusCode == 201) {
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


  Future<void> cartAllDataAPI(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/getMyCart');
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Authorization':' Bearer ${jwtToken1.toString()}',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );
      //var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        List<CartAddItemModelClass> productList = [];
        productList = [CartAddItemModelClass.fromJson(jsonData)];

        _addCartItem = productList;
        log(jsonData.toString());
        notifyListeners();
      } else if(response.statusCode == 400) {
        var jsonData = json.decode(response.body);
        List<CartAddItemModelClass> productList = [];
        productList = [CartAddItemModelClass.fromJson(jsonData)];
        log(jsonData.toString());
        _addCartItem = productList;
      }else if(response.statusCode == 500){
        Future.delayed(const Duration(seconds: 0),() async{
          Navigator.pushNamedAndRemoveUntil(context,
              Routes_Name.LoginScreen, (route) => false);
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        });
      }


    } catch (error) {
      rethrow;
    }
  }

  Future<void> increaseProductQuantity(String cartItemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/increaseProductQuantity');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartItemId": cartItemId,
      });
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
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

  Future<void> decreaseProductQuantity(String cartItemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/decreaseProductQuantity');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartItemId": cartItemId,
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


  Future<void> removeProductFromCart(String cartItemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/removeProductFromCart');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartItemId": cartItemId,
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
