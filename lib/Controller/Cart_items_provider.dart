import 'package:flutter/material.dart';
import 'package:online_ordering_system/Models/ConfirmListModelClass.dart';
import 'package:collection/collection.dart';

import '../Models/FavoriteListModelClass.dart';

class Purchase_items_provider with ChangeNotifier {
  List<FavoriteListModelClass> _PurchaseList = [];

  List<dynamic> get PurchaseList => _PurchaseList;
  int _counter = 1;

  int get counter => _counter;


  void AddItemToCart(FavoriteListModelClass ListModel) {
    _PurchaseList.add(ListModel);
    notifyListeners();
  }

  void RemoveToCart(FavoriteListModelClass ListModel) {
    _PurchaseList.remove(ListModel);
    notifyListeners();
  }

  void cleanCartItem() {
    _PurchaseList.clear();
    notifyListeners();
  }


  int AllItemPrice(){
   Iterable<int> TotalPrice = _PurchaseList.map((e) => e.Price * e.Count);
   TotalPrice.toString();
   final sum = TotalPrice.sum;
   return sum;
  }
}

