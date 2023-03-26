import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:online_ordering_system/Models/ProductListModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/CartAddItemModelClass.dart';
import '../Models/FavoriteListModelClass.dart';

class Purchase_items_provider with ChangeNotifier {
  List<FavoriteListModelClass> _PurchaseList = [];

  List<dynamic> get PurchaseList => _PurchaseList;

  List<CartAddItemModelClass> _addCartItem = [];

  List<dynamic> get addCartItem => _addCartItem;

  Future<void> productAllAPI(String productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print('fcmToken');

      final fcmToken1 = prefs.getString('fcmToken1'.toString()) ?? '';
      final fcmToken0 = prefs.getString('fcmToken0');

      print(productId);



      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/addToCart');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $fcmToken1',
        'Content-Type': 'application/json',
      }, body: {
        "productId": productId,
      });
      var jsonData = json.decode(response.body);
      print(jsonData.toString());
      print(response.statusCode == 201);
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        List<CartAddItemModelClass> productList = [];
        //var productList = ProductAllAPI.fromJson(jsonData);
        productList = [CartAddItemModelClass.fromJson(jsonData)];

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

        _addCartItem = productList ;

        notifyListeners();
      } else {
        var productList = <CartAddItemModelClass>[];

        productList = [
          CartAddItemModelClass(
            status: int.parse(jsonData['status']).toInt(),
            msg: jsonData['msg'],
            data: CartAddItemData(
                userId: '',
                cartId: '',
                quantity: 0,
                productCount: 0,
                productDetails: ProductAllAPIData(
                  id: '',
                  title: '',
                  description: '',
                  price: '',
                  imageUrl: '',
                  v: 0,
                  createdAt: '',
                  updatedAt: '',
                )),
          )
        ];
        _addCartItem = productList;
      }
    } catch (error) {
      throw error;
    }
  }

  void addItemToCart(FavoriteListModelClass ListModel) {
    _PurchaseList.add(ListModel);
    notifyListeners();
  }

  void removeToCart(FavoriteListModelClass ListModel) {
    _PurchaseList.remove(ListModel);
    notifyListeners();
  }

  void cleanCartItem() {
    _PurchaseList.clear();
    notifyListeners();
  }

  int allItemPrice() {
    Iterable<int> totalPrice = _PurchaseList.map((e) => e.Price * e.Count);
    totalPrice.toString();
    final sum = totalPrice.sum;
    return sum;
  }

  void increaseCount(int index) {
    _PurchaseList[index].Count++;
    notifyListeners();
  }

  void decreaseCount(int index) {
    _PurchaseList[index].Count--;
    notifyListeners();
  }

  int allItemCount() {
    Iterable<int> totalCount = _PurchaseList.map((e) => e.Count);
    totalCount.toString();
    final count = totalCount.sum;
    return count;
  }
}
