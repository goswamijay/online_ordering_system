import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Models/GetxProductModel.dart';

import 'GetxCartController.dart';
import 'GetxFavoriteController.dart';

class GetxProductController extends GetxController {
  final cartController = Get.put(GetxCartController());
  final favoriteController = Get.put(GetxFavoriteController());


 // RxList productData = [].obs;
  RxList<GetxProduct> productData = <GetxProduct>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchProductData();
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
