import 'package:online_ordering_system/GetX/Getx_Models/GetxProductModel.dart';
import 'package:get/get.dart';


class GetxFavoriteController extends GetxController{
  RxList favoriteData = [].obs;

  addToFavorite(GetxProduct item){
    favoriteData.add(item);
  }

  removeToFavorite(GetxProduct item){
    favoriteData.remove(item);
  }
}