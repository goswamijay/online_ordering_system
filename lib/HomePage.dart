import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.pink,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
              ),
              label: "Product Screen",
              backgroundColor: Colors.indigo,
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.cart_fill,
                  color: Colors.black,
                ),
                label: "Cart Screen"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.heart_solid,
                  color: Colors.black,
                ),
                label: "Wishlist Screen"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person,
                  color: Colors.black,
                ),
                label: "Wishlist Screen"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.arrow_up_bin_fill,
                  color: Colors.black,
                ),
                label: "Order List"),
          ]),
    );
  }
}
