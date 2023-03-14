import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Views/Account%20Screen/Account%20Main%20Screen.dart';
import 'package:online_ordering_system/Views/Cart%20Screen/Cart%20Main%20Screen.dart';
import 'package:online_ordering_system/Views/Order%20Place%20Screen/Order%20Place%20Main%20Screen.dart';

import 'Views/Favorite Screen/Favorite Main Screen.dart';
import 'Views/Product Screen/Product Main Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  Map<String,List<dynamic>> FavoriteData = {};
  List<dynamic>? FavoriteItems = [];
  PageController controller = PageController();
  int _curr = 0;
  void _onItemTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }
  final List<Widget> _widgetOption = <Widget>[
   // const CartMainScreen(),
    const ProductMainScreen(),
  const CartMainScreen(),
    const FavoriteMainScreen(),
    const AccountMainScreen(),
    const OrderPlaceMainScreen(),
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: PageView(
              allowImplicitScrolling: true,
              scrollDirection: Axis.vertical,
              controller: controller,
              onPageChanged: (num) {
                setState(() {
                  selectedIndex = num;
                });
              },
              children:[_widgetOption.elementAt(selectedIndex)]
            ),), /* Center(
              child: _widgetOption.elementAt(selectedIndex),
            ),*/
           // _widgetOption.elementAt(_selectedIndex),

          Container(
            height: 80,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
              ),
              label: "Product Screen",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.cart_fill,
                ),
                label: "Cart Screen"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.heart_solid,
                ),
                label: "Wishlist Screen"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person_alt,
                ),
                label: "Account Screen"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.arrow_up_bin_fill,
                ),
                label: "Order List"),

          ]),
    );
  }
}
