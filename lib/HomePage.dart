import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Controller/ChangeControllerClass.dart';
import 'package:online_ordering_system/Views/Account%20Screen/Account%20Main%20Screen.dart';
import 'package:online_ordering_system/Views/Cart%20Screen/Cart%20Main%20Screen.dart';
import 'package:online_ordering_system/Views/Order%20Place%20Screen/Order%20Place%20Main%20Screen.dart';
import 'package:provider/provider.dart';

import 'Utils/notificationservice/local_notification_service.dart';
import 'Views/Favorite Screen/Favorite Main Screen.dart';
import 'Views/Product Screen/Product Main Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, List<dynamic>> favoriteData = {};
  List<dynamic>? favoriteItems = [];
  // PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        // print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          //   print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        //print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          // print(message.notification!.title);
          // print(message.notification!.body);
          // print("message.data22 ${message.data['_id']}");
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        // print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          //print(message.notification!.title);
          //print(message.notification!.body);
          //print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
   final controlClassController = Provider.of<ChangeControllerClass>(context);
    return Scaffold(
        body: Stack(
          children: [
            Center(
              child: PageView(
                  controller: controlClassController.pageController,
                  allowImplicitScrolling: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    controlClassController.onPageChange(value);
                    controlClassController.selectedIndex = value;
                  },
                  children: const [
                    ProductMainScreen(),
                    CartMainScreen(),
                    FavoriteMainScreen(),
                    AccountMainScreen(),
                    OrderPlaceMainScreen(),
                  ]),
            ),
            Container(
              height: 80,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controlClassController.selectedIndex,
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.black,
            onTap: controlClassController.onItemTapped,
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
