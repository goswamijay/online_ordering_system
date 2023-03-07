import 'package:flutter/material.dart';
import '../Models/ConfirmListModelClass.dart';
import '../Models/FavoriteListModelClass.dart';


class Place_order_Provider with ChangeNotifier{

  List<ConfirmListModelClass> _ConfirmList = [];

  List<dynamic> get ConfirmList => _ConfirmList;

  void AddItems(ConfirmListModelClass confirmListModelClass){
    _ConfirmList.add(confirmListModelClass);
    notifyListeners();
  }


}