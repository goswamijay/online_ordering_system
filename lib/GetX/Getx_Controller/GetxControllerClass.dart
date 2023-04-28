import 'package:get/get.dart';


class GetControllerClass extends GetxController{
  RxBool searchButton = false.obs;
  RxBool listIsEmpty = false.obs;
  RxInt photoIndex = 0.obs;
  int photoIndex1 = 0;

  int updateIndex(int index){
    photoIndex1 = index;
    update();
    return photoIndex1;
  }
  

}