import 'dart:convert';
import 'dart:developer';

import 'package:online_ordering_system/GetX/Getx_Models/GetxProductModel.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Getx_Models/GetxCardDataModelClass.dart';
import 'package:http/http.dart' as http;

import '../Getx_Utils/Getx_Routes_Name.dart';

class GetxCartController extends GetxController {
  RxList cartData = [].obs;
  RxInt totalPrice1 = 0.obs;
  GetCartAddItemModelClass getCartAddItemModelClass =
      GetCartAddItemModelClass(status: 0, msg: '', cartTotal: 0, data: []);
    var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getCartAllDataAPI();
  }

  Future<void> getCartAllDataAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/getMyCart');
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Authorization': ' Bearer ${jwtToken1.toString()}',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );
      //var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
                isLoading.value = false;

        getCartAddItemModelClass = GetCartAddItemModelClass.fromJson(jsonData);

        update();
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);
        getCartAddItemModelClass = GetCartAddItemModelClass.fromJson(jsonData);
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
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> getAddToCart(String productId) async {
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

  addToCart(GetxProduct item) {
    cartData.add(item);
    update();
  }

  removeFromCart(GetxProduct item) {
    cartData.remove(item);
    update();
  }

  incrementItem(int index) {
    cartData[index].Count++;
    update();
  }

  decrementItem(int index) {
    if (cartData[index].Count > 1) {
      cartData[index].Count--;
    }
    update();
  }

  allItemPrice() {
    Iterable<int> totalPrice = cartData.map((e) => e.Price * e.Count);
    totalPrice.toString();
    totalPrice1.value = totalPrice.sum;
    update();
    return totalPrice1.value;
  }

  clearList() {
    cartData.clear();
    update();
  }
}
