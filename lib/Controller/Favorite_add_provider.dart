import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/FavoriteListModelClass.dart';



class FavoriteAddProvider with ChangeNotifier {


  favoriteAddItemModelClass _favoriteData = favoriteAddItemModelClass(
    status: 0,
    msg: '',
    data: [],
  );

  favoriteAddItemModelClass get favoriteData => _favoriteData;


  bool showItemBool = false;

  showItem(){
    showItemBool = true;
    notifyListeners();
  }

  void updateDataList(favoriteAddItemModelClass newDataList) {
    _favoriteData = newDataList;
    notifyListeners();
  }

  bool isFavorite(String itemId,int index) {
    return _favoriteData.data[index].id.contains(itemId);
  }

  Future<void> addInFavorite(String productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
      final jwtToken0 = prefs.getString('jwtToken');

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/watchList/addToWatchList');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "productId": productId,
      });
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        notifyListeners();
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData);
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> removeFavorite(String wathListItemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
      final jwtToken0 = prefs.getString('jwtToken');

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/watchList/removeFromWatchList');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "wathListItemId": wathListItemId,
      });
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        notifyListeners();
      } else {

      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> favoriteAllDataAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
      final jwtToken0 = prefs.getString('jwtToken');

      log(jwtToken1.toString());

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/watchList/getWatchList');
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

        final favoriteData = favoriteAddItemModelClass.fromJson(jsonData);

        _favoriteData = favoriteData;
        log(jsonData.toString());
        notifyListeners();
      } else {

        final favoriteData = favoriteAddItemModelClass.fromJson(jsonData);

        _favoriteData = favoriteData;
      }
    } catch (error) {
      rethrow;
    }
  }
}





