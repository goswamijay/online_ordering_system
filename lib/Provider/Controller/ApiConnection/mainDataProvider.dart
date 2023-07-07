import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ProductListModelClass.dart';
import '../../Utils/Routes_Name.dart';
import '../Cart_items_provider.dart';

class ApiConnection extends ChangeNotifier {

  ProductAllAPI _productAllAPI = ProductAllAPI(
    status: 0,
    msg: '',
    data: [], totalProduct: 0,
  );

  ProductAllAPI get productAllApi => _productAllAPI;


  bool showItemBool = false;


  showItem(){
    showItemBool = true;
    notifyListeners();
  }


  Future<void> productAllAPI(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
      final jwtToken0 = prefs.getString('jwtToken');

      log(jwtToken1.toString());

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct');
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Authorization':' Bearer ${jwtToken1.toString()}',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );
    /*  var jsonData = json.decode(response.body);
     log(jsonData.toString());*/
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        var productList = ProductAllAPI.fromJson(jsonData);
        _productAllAPI = productList;
    /*    List<ProductAllAPI> productList = [];
        //var productList = ProductAllAPI.fromJson(jsonData);
        productList = [ProductAllAPI.fromJson(jsonData)] ;*/

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

      /*  _productAll = productList;*/

        notifyListeners();
      } else if(response.statusCode == 400) {

        final jsonData = json.decode(response.body);
        var productList = ProductAllAPI.fromJson(jsonData);
        _productAllAPI = productList;
        notifyListeners();
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

}