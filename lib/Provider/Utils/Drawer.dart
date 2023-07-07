import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Routes_Name.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}



class _DrawerWidgetState extends State<DrawerWidget> {
  String email = '';
  String name1 = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    access(context);
  }

  access(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('LoginEmail').toString();
      name1 = prefs.getString('LoginName').toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

             UserAccountsDrawerHeader( // <-- SEE HERE
              decoration: const BoxDecoration(color: Colors.indigo),
              accountName: Text(
                name1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              accountEmail: Text(
               email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              currentAccountPicture: const CircleAvatar(backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/21/21104.png')),
            ),
            ListTile(
              title: const Text(
                'Product Screen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(CupertinoIcons.home),
              onTap: () {
                Navigator.pushNamed(context, Routes_Name.ProductMainScreen);
              },
            ),


            ListTile(
              title: const Text(
                'Cart Screen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(CupertinoIcons.cart_fill),
              onTap: () {
                Navigator.pushNamed(context, Routes_Name.CartMainScreen);
              },
            ),

            ListTile(
              title: const Text(
                'Wishlist Screen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(CupertinoIcons.heart_solid),
              onTap: () {
                Navigator.pushNamed(context, Routes_Name.FavoriteMainScreen);
              },
            ),

            ListTile(
              title: const Text(
                'Account Screen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(CupertinoIcons.person_alt),
              onTap: () {
                Navigator.pushNamed(context, Routes_Name.AccountMainScreen);
              },
            ),

            ListTile(
              title: const Text(
                'Order List Screen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(CupertinoIcons.arrow_up_bin_fill),
              onTap: () {
                Navigator.pushNamed(context, Routes_Name.OrderPlaceMainScreen);
              },
            ),
            const Divider(thickness: 2),
            ListTile(
              title: const Text(
                'Send feedback',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.email_rounded),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Tips',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.tips_and_updates_outlined),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Setting',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(CupertinoIcons.settings),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(CupertinoIcons.info),
              onTap: () {},
            ),
            const Divider(thickness: 2),
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(CupertinoIcons.square_arrow_left),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushNamedAndRemoveUntil(context, Routes_Name.OnBoardingScreen, (route) => false);
              },
            ),
            const Divider(thickness: 2),
            const Align(
              alignment: Alignment.bottomRight,
              child:  Padding(
                padding: EdgeInsets.all(3.0),
                child: Text('Version: 1.0'),
              ),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child:  Padding(
                padding: EdgeInsets.all(3.0),
                child: Text('Developed By-Jay Goswami'),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),

      ),
    );
  }
}


