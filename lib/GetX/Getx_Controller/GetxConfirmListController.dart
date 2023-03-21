import 'package:get/get.dart';

import '../Getx_Models/GetxConfirmOrderModel.dart';

class GetxConfirmListController extends GetxController{
  RxList confirmData = [].obs;

  addToConfirm(GetConfirmListModelClass item){
    confirmData.add(item);
    update();
  }
}