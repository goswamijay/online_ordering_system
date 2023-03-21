import 'package:online_ordering_system/GetX/Getx_Models/GetxProductModel.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';


class GetxCartController extends GetxController{
  RxList cartData = [].obs;
  RxInt totalPrice1 = 0.obs;
 // RxBool isAdded = cartData.contains( productController.productData[index]).obs;
  addToCart(GetxProduct item){
    cartData.add(item);
    update();
  }

  removeFromCart(GetxProduct item){
    cartData.remove(item);
    update();
  }

  incrementItem(int index){
   cartData[index].Count++;
    update();
  }

  decrementItem(int index){
    if(cartData[index].Count > 1) {
      cartData[index].Count --;
    }
    update();
  }

  allItemPrice(){
    Iterable<int> totalPrice = cartData.map((e) => e.Price * e.Count);
    totalPrice.toString();
    totalPrice1.value = totalPrice.sum;
    update();
    return totalPrice1.value;
  }

  clearList(){
    cartData.clear();
    update();
  }

}