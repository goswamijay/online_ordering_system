import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:online_ordering_system/Bloc/BlocAccountMainScreen/BlocAccountMainScreen.dart';
import '../Utils/notificationservice/local_notification_service.dart';
import 'BlocCartMainScreen/BlocCartMainScreen.dart';
import 'BlocFavoriteMainScreen/BlocFavoriteMainScreen.dart';
import 'BlocOrderPlaceMainScreen/BlocOrderPlaceMainScreen.dart';
import 'BlocProductMainScreen/BlocProductMainScreen.dart';

class BlocHomePage extends StatefulWidget {
  const BlocHomePage({Key? key}) : super(key: key);

  @override
  State<BlocHomePage> createState() => _BlocHomePageState();
}

class _BlocHomePageState extends State<BlocHomePage> {
  int selectedIndex = 0;
  PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {}
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {}
      },
    );

    // 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
  }

  void _onItemTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _widBlocOption = <Widget>[
    const BlocProductMainScreen(),
    const BlocCartMainScreen(),
    const BlocFavoriteMainScreen(),
    const BlocAccountMainScreen(),
    const BlocOrderPlaceMainScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        debounceDuration: Duration.zero,
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          if (connectivity == ConnectivityResult.none) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                //  child,
                AlertDialog(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          const Text('No Internet Connection'),
                          const Spacer(),
                          InkWell(
                            onTap: () => exit(0),
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: const Icon(Icons.close),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Center(
                          child: Icon(
                            Icons.warning_amber_sharp,
                            size: 48,
                          ),
                        ),
                      )
                    ],
                  ),
                  content: const Text('Please check your internet connection.'),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  height: 40.0,
                  bottom: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: connected ? Colors.green : Colors.indigo,
                      child: connected
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "YOU ARE OFFLINE",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "YOU ARE OFFLINE",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                SizedBox(
                                  width: 12.0,
                                  height: 12.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            );
          }
          return child;
        },
        child: SafeArea(
          top: false,
          child: Stack(
            children: [
              Center(
                child: _widBlocOption.elementAt(selectedIndex),
              ),
              Container(
                height: 80,
              ),
            ],
          ),
        ),
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
                label: "Place Order"),
          ]),
    );
  }
}
