import 'package:flutter/material.dart';

import 'FavoriteListModelClass.dart';

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

  void decrement() {
    if (_counter > 1) {
      _counter--;
      notifyListeners();
    }
  }

  void increment() {
    _counter++;
    notifyListeners();
  }
}

