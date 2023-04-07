import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ProductListModelClass.dart';
import '../../Utils/Routes_Name.dart';
import '../Cart_items_provider.dart';

class ApiConnection extends ChangeNotifier {
  List<ProductAllAPI> _productAll = [];
  List<dynamic> get productAll => _productAll;


  bool showItemBool = false;
  bool addedInCartBool = false;
  bool addedInFavoriteBool = false;

  int _totalItem = 0;
  int get totalItem => _totalItem;
  bool isFavorite1 =false;
  showCart(BuildContext context){
    final cartProvider = Provider.of<purchase_items_provider>(context);

    Future.delayed(const Duration(seconds: 3),(){
      _totalItem = productAll[0].totalProduct.length ?? '0';
    });
    notifyListeners();
  }



  showItem(){
    showItemBool = true;
    notifyListeners();
  }

  addedInCart(int index){
   if(productAll[0].data[index].quantity != 0){
     addedInCartBool = true;
     notifyListeners();

   }else{
     addedInCartBool = false;
     notifyListeners();

   }
  }

  addedInFavorite(int index){
    if(productAll[0]
        .data[index].watchListItemId !=
        ''){
      addedInFavoriteBool = true;
      notifyListeners();
    }else{
      addedInFavoriteBool =false;
      notifyListeners();
    }
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
      var jsonData = json.decode(response.body);
     log(jsonData.toString());
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
      } else if(response.statusCode == 400) {

        List<ProductAllAPI> productList = [];
        //var productList = ProductAllAPI.fromJson(jsonData);
        productList = [ProductAllAPI.fromJson(jsonData)] ;
        _productAll = productList;

        /* var productList = <ProductAllAPI>[];

        productList = [
          ProductAllAPI(
              status: int.parse(jsonData['status']).toInt(),
              msg: jsonData['msg'],
              totalProduct: 0,
              data: [ProductAllAPIData(
                id: '',
                title: '',
                description: '',
                price: '',
                imageUrl: '', quantity: 0, cartItemId: '',

              )])
        ];
        _productAll = productList;*/
      }else{
        Future.delayed(const Duration(seconds: 0),(){
          Navigator.pushNamedAndRemoveUntil(context,
              Routes_Name.LoginScreen, (route) => false);
        });
      }
    } catch (error) {
      rethrow;
    }
  }

}