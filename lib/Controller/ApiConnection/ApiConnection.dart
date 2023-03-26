import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ProductListModelClass.dart';

class ApiConnection extends ChangeNotifier {
  List<ProductAllAPI> _productAll = [];
  List<dynamic> get productAll => _productAll;

  bool showItemBool = false;

  showItem(){
    showItemBool = true;
    notifyListeners();
  }

  Future<void> productAllAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print('fcmToken');

      final fcmToken1 = prefs.getString('fcmToken1'.toString()) ?? '';
      final fcmToken0 = prefs.getString('fcmToken0');

      print(fcmToken1.toString());

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct');
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Authorization':' Bearer ${fcmToken1.toString()}',
              "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );
      var jsonData = json.decode(response.body);
      print(jsonData.toString());
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<ProductAllAPI> productList = [];
        //var productList = ProductAllAPI.fromJson(jsonData);
      productList = [ProductAllAPI.fromJson(jsonData)] ;

     /*   productList = [
          ProductAllAPI(
              status: int.parse(jsonData['staus']).toInt(),
              msg: jsonData['msg'],
              totalProduct: 0,
              data: [ProductAllAPIData(
                id: jsonData['data']['_id'].toString(),
                title: jsonData['data']['title'].toString(),
                description: jsonData['data']['description'].toString(),
                price: jsonData['data']['price'].toString(),
                imageUrl: jsonData['data']['imageUrl'].toString(),
                v: int.parse(jsonData['data']['__v'].toString()),
                createdAt: jsonData['data']['createdAt'].toString(),
                updatedAt: jsonData['data']['updatedAt'].toString(),
              )])
        ];*/

        _productAll = productList;

        notifyListeners();
      } else {
        var productList = <ProductAllAPI>[];

        productList = [
          ProductAllAPI(
              status: int.parse(jsonData['staus']).toInt(),
              msg: jsonData['msg'],
              totalProduct: 0,
              data: [ProductAllAPIData(
                id: '',
                title: '',
                description: '',
                price: '',
                imageUrl: '',
                v: 0,
                createdAt: '',
                updatedAt: '',
              )])
        ];
        _productAll = productList;
      }
    } catch (error) {
      throw error;
    }
  }
}
