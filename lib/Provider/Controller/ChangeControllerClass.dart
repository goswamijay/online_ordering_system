import 'package:flutter/cupertino.dart';

class ChangeControllerClass extends ChangeNotifier {
  int photoIndex1 = 0;
  bool searchButton = false;
  bool listIsEmpty1 = false;
  int selectedIndex = 0;
  TextEditingController controller = TextEditingController();
  List<dynamic> searchItems = [];
  PageController pageController = PageController();

  void searchButtonPress() {
    searchButton = true;
    notifyListeners();
  }

  void searchButtonUnPress() {
    searchButton = false;
    notifyListeners();
  }

  void photoIndex(int index) {
    photoIndex1 = index;
    notifyListeners();
  }

  void listIsEmpty() {
    listIsEmpty1 = true;
    notifyListeners();
  }

  void listNotEmpty() {
    listIsEmpty1 = false;
    notifyListeners();
  }

  void onItemTapped(index) {
    selectedIndex = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    notifyListeners();
  }

  void onPageChange(index) {
    selectedIndex = index;
    notifyListeners();
  }
}
