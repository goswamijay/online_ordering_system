import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawerWidget(BuildContext context,Color color){
    return SizedBox(
        width: 280,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: BoxDecoration(
                  color: color,
                ),
                child: const Text(
                  'Drawer Header',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
            ],
          ),
        ),
    );
  }