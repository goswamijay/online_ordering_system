import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Controller/GetxCartController.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';

import '../../../Utils/Drawer.dart';

class GetCartMainScreen extends StatefulWidget {
  const GetCartMainScreen({Key? key}) : super(key: key);

  @override
  State<GetCartMainScreen> createState() => _GetCartMainScreenState();
}

class _GetCartMainScreenState extends State<GetCartMainScreen> {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(GetxCartController());

    return Scaffold(
      drawer: drawerWidget(context, Colors.indigo),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(GetxRoutes_Name.GetxHomePage);
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
          padding: EdgeInsets.only(top: 12.0),
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
                Navigator.pushNamed(context, GetxRoutes_Name.GetxHomePage);
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
                          child: Text(
                            " FavoriteProvider.FavoriteList.length.toString(),",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
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
      body: Column(
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
                padding: const EdgeInsets.all(8.0),
                child: fullList1(context),
              ),
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
                          Text(
                            "Total Items (${cartController.cartData.length}).toString()})",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            "CartProvider.allItemPrice().toString()",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
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
                          Text(
                            " CartProvider.allItemPrice().toString()",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          /*Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                height: size.height / 20,
                color: Colors.orange,
                child: Center(
                    child: Text(
                  "Total Price :- ${CartProvider.allItemPrice().toString()}",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),*/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return cartController.cartData.isNotEmpty
                          ? AlertDialog(
                              title: const Text("Confirm to Place Order"),
                              content: Text(
                                  "You added ${cartController.cartData.length} Product and Total Price {CartProvider.allItemPrice()}"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Not Now'),
                                ),
                                TextButton(
                                    child: const Text('Place Order'),
                                    onPressed: () {
                                      setState(() {});
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
                  height: Get.height / 15,
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
    final cartController = Get.put(GetxCartController());

    Size size = MediaQuery.of(context).size;
    return cartController.cartData.isEmpty
        ? Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/cart.gif"),
                const Center(
                  child: Text(
                    "No Items added in cart ....!",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          )
        : GetBuilder<GetxCartController>(builder: (controller) {
            return ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                //  shrinkWrap: true,

                itemCount: cartController.cartData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Image(
                                      image: AssetImage(cartController
                                          .cartData[index].ImageURL),
                                      // image: AssetImage('first.jpg'),
                                      width: size.width / 2,
                                      height: size.height / 4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: cartController.cartData.isEmpty
                                              ? InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    CupertinoIcons.heart_solid,
                                                    size: 16,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {},
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
                                        cartController.cartData[index].Name,
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
                                        cartController
                                            .cartData[index].ShortDescription,
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
                                              alignment: Alignment.topLeft,
                                              child: AutoSizeText(
                                                '₹${cartController.cartData[index].Count * cartController.cartData[index].Price}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  cartController.removeFromCart(
                                                      cartController
                                                          .cartData[index]);
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                //onTap: CartProvider.decrement(CartProvider.PurchaseList[index].Count),
                                                onTap: () {
                                                  setState(() {});
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
                                                cartController
                                                    .cartData[index].Count
                                                    .toString(),
                                                //CartProvider.counter.toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              InkWell(
                                                /*     onTap: (){CartProvider.increment(CartProvider.PurchaseList[index].Count);},*/
                                                onTap: () {
                                                  setState(() {});
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
                  );
                });
          });
  }
}
