import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_ordering_system/Controller/Favorite_add_provider.dart';
import 'package:online_ordering_system/Controller/place_Order_Items.dart';
import 'package:provider/provider.dart';
import '../../Controller/ApiConnection/firebase_api_calling.dart';
import '../../Controller/ApiConnection/mainDataProvider.dart';
import '../../Controller/Cart_items_provider.dart';
import '../../Utils/Drawer.dart';
import '../../Utils/Routes_Name.dart';

class CartMainScreen extends StatefulWidget {
  const CartMainScreen({Key? key}) : super(key: key);

  @override
  State<CartMainScreen> createState() => _CartMainScreenState();
}

class _CartMainScreenState extends State<CartMainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accessApi(context);
  }

  /* static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();*/

  List<dynamic> cartData = [];

  String cartItem = '';

  accessApi(BuildContext context) async {
    final apiConnection1 =
        Provider.of<cart_items_provider>(context, listen: false);

    apiConnection1.showItemBool = false;
    await apiConnection1.cartAllDataAPI(context);

    setState(() {
      cartData = apiConnection1.addCartItem.map((e) => e).toList();
      apiConnection1.showItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<cart_items_provider>(context);
    final confirmProvider = Provider.of<PlaceOrderProvider>(context);
    final favoriteProvider = Provider.of<FavoriteAddProvider>(context);
    final firebaseApiProvider = Provider.of<FirebaseApiCalling>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(Routes_Name.HomePage);
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.black,
                ),
              )),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Center(
              child: Text(
            "My Cart",
            style: TextStyle(color: Colors.black),
          )),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 12.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes_Name.FavoriteMainScreen);
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: SizedBox.fromSize(
                size: const Size.fromRadius(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: FittedBox(
                        child: Icon(
                          CupertinoIcons.heart_solid,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red[900]),
                          width: 34 / 2,
                          height: 34 / 2,
                          child: cartProvider.showItemBool
                              ? Text(
                                  favoriteProvider.favoriteData.data.length
                                      .toString(),
                                  /*   apiConnection.productAll[0].totalProduct
                                    .toString() ?? '0''0',*/
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      backgroundColor: Colors.white,
      body: cartProvider.showItemBool
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(246, 244, 244, 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.0),
                            topLeft: Radius.circular(16.0))),
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: fullList1(context)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(246, 244, 244, 1),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                cartProvider.showItemBool
                                    ? Text(
                                        "Total Items (${cartProvider.addCartItem[0].data.length})",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const CircularProgressIndicator(),
                                const Spacer(),
                                cartProvider.showItemBool
                                    ? Text(
                                        " \$${cartProvider.addCartItem[0].cartTotal.toStringAsFixed(3)}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const CircularProgressIndicator(),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Text(
                                  "Total Price :-",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                cartProvider.showItemBool
                                    ? Text(
                                        " \$${cartProvider.addCartItem[0].cartTotal.toStringAsFixed(3)}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const CircularProgressIndicator(),
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, bottom: 6.0, top: 6.0),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return cartProvider.addCartItem[0].data.isNotEmpty
                          ? AlertDialog(
                              title: const Text("Confirm to Place Order"),
                              content: Text(
                                  "You added ${cartProvider.addCartItem[0].data.length} Product and Total Price ${cartProvider.addCartItem[0].cartTotal.toStringAsFixed(3)}"),
                              actions: [
                                TextButton(
                                  child: const Text('Not Now'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                    child: const Text('Place Order'),
                                    onPressed: () async {
                                      await confirmProvider.placeOrder(
                                          cartData[0].data[0].cartId.toString(),
                                          cartData[0].cartTotal.toString());

                                      Future.delayed(const Duration(seconds: 0),
                                          () {
                                        accessApi(context);
                                        Navigator.pop(context);
                                      firebaseApiProvider.sendPushNotification("Online Ordering System", "You added ${cartProvider.addCartItem[0].data.length} Product and Total Price ${cartProvider.addCartItem[0].cartTotal.toStringAsFixed(3)}");
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Lottie.asset(
                                                    height: 100,
                                                    width: 100,
                                                    'assets/Animation/placeholder.json'),
                                              );
                                            });
                                      });


                                      /* FirebaseMessaging.onMessage.listen(
                                        (message) async {
                                          // print("FirebaseMessaging.onMessage.listen");
                                          if (message.notification != null) {
                                            try {
                                              final id = DateTime.now()
                                                      .millisecondsSinceEpoch ~/
                                                  1000;
                                              NotificationDetails
                                                  notificationDetails =
                                                  const NotificationDetails(
                                                android:
                                                    AndroidNotificationDetails(
                                                  "OnlineOrdering system",
                                                  "pushnotificationappchannel",
                                                  'your other channel description',
                                                  importance: Importance.max,
                                                  priority: Priority.high,
                                                ),
                                              );

                                              await _notificationsPlugin.show(
                                                id,
                                                'Online Ordering System',
                                                "You added ${cartProvider.addCartItem[0].data.length} Product and Total Price ${cartProvider.addCartItem[0].cartTotal}",
                                                notificationDetails,
                                                payload: message.data['_id'],
                                              );
                                            } on Exception catch (e) {
                                              log(e.toString());
                                            }
                                          }
                                        },
                                      );*/
                                    }),
                              ],
                            )
                          : AlertDialog(
                              title: const Text("No Items Added in Cart"),
                              content: const Text("Please add item in cart"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Not Now'),
                                ),
                                TextButton(
                                    child: const Text('Okay'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ],
                            );
                    },
                  );
                },
                child: Container(
                  height: size.height / 15,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(16)),
                  child: const Center(
                      child: Text(
                    "Place Order ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    final cartProvider = Provider.of<cart_items_provider>(context);
    final favoriteProvider = Provider.of<FavoriteAddProvider>(context);
    final apiConnection1 = Provider.of<ApiConnection>(context);

    Size size = MediaQuery.of(context).size;
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          accessApi(context);
        },
        child: cartProvider.showItemBool
            ? cartProvider.addCartItem[0].data.length == 0
                ? Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image(image: AssetImage('assets/cart1.png')),
                        Image.asset(
                          "assets/cart1.png",
                          height: size.height / 2,
                          width: size.width / 2,
                        ),
                        const Center(
                          child: Text(
                            "No Items added in cart ....!",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    //  shrinkWrap: true,

                    itemCount: cartProvider.addCartItem[0].data.length,
                    itemBuilder: (context, index) {
                      /*  bool isSaved = apiConnection1.productAll[0].data[index]
                      .watchListItemId.any((element1) =>
                      element1.Name.contains(
                          favoriteProvider.favoriteData.data[index].id));*/

                      return InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes_Name.ProductDetailsScreen,
                              arguments: {
                                'Price': cartData[0]
                                    .data[index]
                                    .productDetails
                                    .price,
                                'Name': cartData[0]
                                    .data[index]
                                    .productDetails
                                    .title,
                                'ImageURL': cartData[0]
                                    .data[index]
                                    .productDetails
                                    .imageUrl,
                                'ShortDescription': cartData[0]
                                    .data[index]
                                    .productDetails
                                    .description,
                                'Index': index,
                              });
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Image(
                                            image: NetworkImage(cartData[0]
                                                .data[index]
                                                .productDetails
                                                .imageUrl),
                                            // image: AssetImage('first.jpg'),
                                            fit: BoxFit.contain,

                                            width: size.width / 2,
                                            height: size.height / 5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 5.0,
                                          bottom: 8.0,
                                          top: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: apiConnection1
                                                            .productAllApi
                                                            .data[index]
                                                            .watchListItemId !=
                                                        ''
                                                    ? InkWell(
                                                        onTap: () async {
                                                          favoriteProvider
                                                              .removeFavorite(
                                                                  apiConnection1
                                                                      .productAllApi
                                                                      .data[
                                                                          index]
                                                                      .watchListItemId);

                                                          apiConnection1
                                                              .productAllAPI(
                                                                  context);
                                                        },
                                                        child: const Icon(
                                                          CupertinoIcons
                                                              .heart_solid,
                                                          size: 16,
                                                          color: Colors.red,
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          favoriteProvider
                                                              .addInFavorite(
                                                                  cartData[0]
                                                                      .data[
                                                                          index]
                                                                      .productDetails
                                                                      .id);

                                                          apiConnection1
                                                              .productAllAPI(
                                                                  context);
                                                          // accessApi(context);
                                                        },
                                                        child: const Icon(
                                                          CupertinoIcons.heart,
                                                          size: 16,
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: size.width,
                                            child: AutoSizeText(
                                              cartData[0]
                                                  .data[index]
                                                  .productDetails
                                                  .title,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 30),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height / 70,
                                          ),
                                          SizedBox(
                                            width: size.width,
                                            child: AutoSizeText(
                                              cartData[0]
                                                  .data[index]
                                                  .productDetails
                                                  .description,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 30),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height / 70,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  width: size.width,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: AutoSizeText(
                                                      '\$${cartData[0].data[index].productDetails.price}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25),
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                    onPressed: () async {
                                                      await cartProvider
                                                          .removeProductFromCart(
                                                              cartProvider
                                                                  .addCartItem[
                                                                      0]
                                                                  .data[index]
                                                                  .id);
                                                      Future.delayed(
                                                          const Duration(
                                                              milliseconds: 0),
                                                          () async {
                                                        await cartProvider
                                                            .cartAllDataAPI(
                                                                context);
                                                        // accessApi(context);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        CupertinoIcons.delete)),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        await cartProvider
                                                            .decreaseProductQuantity(
                                                                cartData[0]
                                                                    .data[index]
                                                                    .id);

                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    0),
                                                            () async {
                                                          await cartProvider
                                                              .cartAllDataAPI(
                                                                  context);
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey[200],
                                                        radius: 14,
                                                        child: const Center(
                                                            child: Icon(
                                                          Icons.remove,
                                                          color: Colors.black,
                                                        )),
                                                      ),
                                                    ),
                                                    Text(
                                                      cartProvider
                                                          .addCartItem[0]
                                                          .data[index]
                                                          .quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        await cartProvider
                                                            .increaseProductQuantity(
                                                          cartData[0]
                                                              .data[index]
                                                              .id,
                                                        );

                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 0),
                                                            () async {
                                                          await cartProvider
                                                              .cartAllDataAPI(
                                                                  context);

                                                          // accessApi(context);
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey[200],
                                                        radius: 14,
                                                        child: const Center(
                                                            child: Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        )),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    })
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
