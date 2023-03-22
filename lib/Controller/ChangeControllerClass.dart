import 'package:flutter/cupertino.dart';

class ChangeControllerClass extends ChangeNotifier{
  int photoIndex1 = 0;
  bool searchButton = false;
  bool listIsEmpty1 = false;

  void searchButtonPress(){
    searchButton = true;
    notifyListeners();
  }

  void searchButtonUnPress(){
    searchButton = false;
    notifyListeners();
  }

  void photoIndex(int index){
    photoIndex1 = index;
    notifyListeners();
  }

  void listIsEmpty(){
    listIsEmpty1 = true;
    notifyListeners();
  }
  void listNotEmpty(){
    listIsEmpty1 = false;
    notifyListeners();
  }



}