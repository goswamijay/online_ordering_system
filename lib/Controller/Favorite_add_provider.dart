import 'dart:collection';

import 'package:flutter/material.dart';

import '../Models/FavoriteListModelClass.dart';



class Favorite_add_provider with ChangeNotifier {

  List<FavoriteListModelClass> _FavoriteList = [  ];
//  UnmodifiableListView<FavoriteList> get FavoriteList1 => UnmodifiableListView(_FavoriteList);

   List<dynamic> get FavoriteList => _FavoriteList;

  void AddFavoriteItems(FavoriteListModelClass favoriteList){

    _FavoriteList.add(favoriteList );
    notifyListeners();
  }
  void RemoveFavoriteItems(FavoriteListModelClass favoriteList) {
    _FavoriteList.remove(favoriteList);
    notifyListeners();
  }
/*
  void RemoveFavoriteItems(int value){
    _FavoriteList.remove(value);
    notifyListeners();
  }
*/

  bool isExist(List FavoriteList){
    final isExist = _FavoriteList.contains(FavoriteList);
    return isExist;
  }

  void ClearFavorite(){
    _FavoriteList = [];
    notifyListeners();
  }
}





