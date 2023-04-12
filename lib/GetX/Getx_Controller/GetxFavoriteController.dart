import 'dart:convert';
import 'dart:developer';

import 'package:online_ordering_system/GetX/Getx_Models/GetxFavoriteModel.dart';
import 'package:online_ordering_system/GetX/Getx_Models/GetxProductModel.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetxFavoriteController extends GetxController {
  RxList favoriteData = [].obs;
 var isLoading = true.obs;
GetFavoriteAddItemModelClass getFavoriteAddItemModelClass = GetFavoriteAddItemModelClass(status: 0, msg: '', data: [],);
  @override
  void onInit() {
    super.onInit();
    favoriteAllDataAPI();
  }


  addToFavorite(GetxProduct item) {
    favoriteData.add(item);
    update();
  }

  removeToFavorite(GetxProduct item) {
    favoriteData.remove(item);
    update();
  }

  Future<void> favoriteAllDataAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

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

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        getFavoriteAddItemModelClass = GetFavoriteAddItemModelClass.fromJson(jsonData);
        isLoading = false.obs;
        update();


      } else if(response.statusCode == 400) {
        var jsonData = json.decode(response.body);
        getFavoriteAddItemModelClass = GetFavoriteAddItemModelClass.fromJson(jsonData);
        update();
      }else if(response.statusCode == 500){
        Get.offAllNamed(GetxRoutes_Name.GetxLoginScreen);
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      }
    } catch (error) {
      rethrow;
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> getAddInFavorite(String productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

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
        update();
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData);
        update();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getRemoveFavorite(String wathListItemId) async {
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

}
