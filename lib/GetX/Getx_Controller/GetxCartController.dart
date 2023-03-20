import 'package:online_ordering_system/GetX/Getx_Models/GetxProductModel.dart';

import '../Getx_Models/GetxFavoriteModel.dart';
import 'package:get/get.dart';


class GetxCartController extends GetxController{
  RxList cartData = [].obs;

  addToCart(GetxProduct item){
    cartData.add(item);
  }

  removeFromCart(GetxProduct item){
    cartData.remove(item);
  }

}