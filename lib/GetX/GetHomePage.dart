import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/GetX/Getx_Views/GetFavorite/GetFavoriteMainScreen.dart';
import 'Getx_Views/GetCartMainScreen/GetCartMainScreen.dart';
import 'Getx_Views/GetProductMainScreen/GetProductMainScreen.dart';


class GetHomePage extends StatefulWidget {
  const GetHomePage({Key? key}) : super(key: key);

  @override
  State<GetHomePage> createState() => _GetHomePageState();
}

class _GetHomePageState extends State<GetHomePage> {

  int selectedIndex = 0;
  PageController controller = PageController();
  int _curr = 0;

  void _onItemTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }
  final List<Widget> _widgetOption = <Widget>[
    // const CartMainScreen(),
    const GetProductMainScreen(),
    const GetCartMainScreen(),
    const GetFavoriteMainScreen(),
    const GetCartMainScreen(),
    const GetProductMainScreen(),
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
