import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Models/GetxProductModel.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GetxCartController.dart';
import 'GetxFavoriteController.dart';
import 'package:http/http.dart' as http;

class GetxProductController extends GetxController {
  final cartController = Get.put(GetxCartController());
  final favoriteController = Get.put(GetxFavoriteController());


 // RxList productData = [].obs;
  RxList<GetxProduct> productData = <GetxProduct>[].obs;
  RxList<GetProductAllAPI> mainData = <GetProductAllAPI>[].obs;
  var isLoading = true.obs;
  bool isLoadingItem = false;

  GetProductAllAPI getProductAllAPI = GetProductAllAPI(status: 1, msg: '', totalProduct: 0, data: []);
  @override
  void onInit() {
    super.onInit();
    productAllAPI();
  }

  @override
  void onReady(){
    super.onReady();
    isLoading.value = false;
    isLoadingItem = false;
  }

  Future<void> productAllAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
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
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        isLoading.value = false;
        isLoadingItem = true;
        getProductAllAPI = GetProductAllAPI.fromJson(jsonData);

        update();
      } else if(response.statusCode == 400) {

        final jsonData = json.decode(response.body);
        getProductAllAPI = GetProductAllAPI.fromJson(jsonData);
        isLoadingItem = true;
        update();
      }else if(response.statusCode == 500){
        Future.delayed(const Duration(seconds: 0),() async{
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



  fetchProductData() {
    RxList<GetxProduct> mainData = [
      GetxProduct(
        Name: 'iPhone 11 Pro Max',
        Price: 120000,
        ShortDescription:
            'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
        ImageURL: "assets/ItemsPhoto/iphone_11.png",
      ),
      GetxProduct(
        Name: 'iPhone 12 Pro Max',
        Price: 140000,
        ShortDescription:
            'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
        ImageURL: "assets/ItemsPhoto/iphone_12.png",
      ),
      GetxProduct(
        Name: 'iPhone 13 Pro Max',
        Price: 160000,
        ShortDescription:
            'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
        ImageURL: "assets/ItemsPhoto/iphone_13.png",
      ),
      GetxProduct(
        Name: 'iPhone 14 Pro Max',
        Price: 180000,
        ShortDescription:
            'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
        ImageURL: "assets/ItemsPhoto/iphone_14.png",
      ),
      GetxProduct(
        Name: 'iPhone 15 pro',
        Price: 200000,
        ShortDescription:
            'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
        ImageURL: "assets/ItemsPhoto/iphone_12.png",
      ),
    ].obs;

    productData.assignAll(mainData);
    update();
  }
}
