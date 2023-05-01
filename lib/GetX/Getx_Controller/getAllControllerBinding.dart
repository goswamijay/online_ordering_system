import 'package:get/get.dart';

import 'GetxAuthenticationController.dart';
import 'GetxCartController.dart';
import 'GetxConfirmListController.dart';
import 'GetxControllerClass.dart';
import 'GetxFavoriteController.dart';
import 'GetxFirebaseApiCalling.dart';
import 'GetxProductController.dart';

class GetAllControllerBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GetAuthenticationController>(() => GetAuthenticationController());
    Get.lazyPut<GetxCartController>(() => GetxCartController());
    Get.lazyPut<GetxConfirmListController>(() => GetxConfirmListController());
    Get.lazyPut<GetControllerClass>(() => GetControllerClass());
    Get.lazyPut<GetxFavoriteController>(() => GetxFavoriteController());
    Get.lazyPut<GetFirebaseApiCalling>(() => GetFirebaseApiCalling());
    Get.lazyPut<GetxProductController>(() => GetxProductController());
  }
}