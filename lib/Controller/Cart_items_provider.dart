import 'package:flutter/material.dart';
import 'package:online_ordering_system/Models/ConfirmListModelClass.dart';
import 'package:collection/collection.dart';

import '../Models/FavoriteListModelClass.dart';

class Purchase_items_provider with ChangeNotifier {
  List<FavoriteListModelClass> _PurchaseList = [];

  List<dynamic> get PurchaseList => _PurchaseList;
  int _counter = 1;
  int get counter => _counter;

  void addItemToCart(FavoriteListModelClass ListModel) {
    _PurchaseList.add(ListModel);
    notifyListeners();
  }

  void removeToCart(FavoriteListModelClass ListModel) {
    _PurchaseList.remove(ListModel);
    notifyListeners();
  }

  void cleanCartItem() {
    _PurchaseList.clear();
    notifyListeners();
  }

  int allItemPrice() {
    Iterable<int> totalPrice = _PurchaseList.map((e) => e.Price * e.Count);
    totalPrice.toString();
    final sum = totalPrice.sum;
    return sum;
  }

  void increaseCount(int index){
    _PurchaseList[index].Count++;
    notifyListeners();
  }

  void decreaseCount(int index){
    _PurchaseList[index].Count--;
    notifyListeners();
  }

  int allItemCount(){
    Iterable<int> totalCount = _PurchaseList.map((e) => e.Count);
    totalCount.toString();
    final count = totalCount.sum;
    return count;
  }
}
