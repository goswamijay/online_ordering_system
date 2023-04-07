import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';

import '../../../Utils/Drawer.dart';
import '../../Getx_Controller/GetxCartController.dart';
import '../../Getx_Controller/GetxFavoriteController.dart';

class GetFavoriteMainScreen extends StatefulWidget {
  const GetFavoriteMainScreen({Key? key}) : super(key: key);

  @override
  State<GetFavoriteMainScreen> createState() => _GetFavoriteMainScreenState();
}

class _GetFavoriteMainScreenState extends State<GetFavoriteMainScreen> {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(GetxCartController());
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: InkWell(
              onTap: () {
                Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
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
            "Favorite Items",
            style: TextStyle(color: Colors.black),
          )),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 12.0),
            child: Obx(() =>  InkWell(
              onTap: () {
               Get.toNamed(GetxRoutes_Name.GetxCartMainScreen);
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
                          CupertinoIcons.cart_fill,
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
                            cartController.cartData.length.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),)
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: fullList1(context),
          ),
        ),
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());

    return favoriteController.favoriteData.isEmpty
        ? Container(
            height: size.height,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/favourite.gif"),
                const Text(
                  "Not any items added in Favorite ....!",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          )
        : GetBuilder<GetxFavoriteController>(builder: (controller) {
            return GetBuilder<GetxCartController>(builder: (controller) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: favoriteController.favoriteData.length,
                  itemBuilder: (context, index) {
                   /* bool isAddedInCart =
                    cartController.cartData.contains(favoriteController.favoriteData[index]);
                    bool isSaved = favoriteController.favoriteData
                        .contains(favoriteController.favoriteData[index]);*/

                    bool isSaved = favoriteController.favoriteData
                        .any((element) => element.Name.contains(favoriteController.favoriteData[index].Name));
                    bool isAddedInCart = cartController.cartData
                        .any((element1) => element1.Name.contains(favoriteController.favoriteData[index].Name));
                    return Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Image(
                                  image: AssetImage(favoriteController
                                      .favoriteData[index].ImageURL),
                                  width: size.width / 2,
                                  height: size.height / 4,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: isSaved
                                            ? InkWell(
                                                onTap: () {
                                                  favoriteController
                                                      .removeToFavorite(
                                                      favoriteController.favoriteData[
                                                      index]);
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Product Remove From Favorite!",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      backgroundColor:
                                                      Colors.indigo,
                                                      duration:
                                                      Duration(seconds: 1),
                                                    ),
                                                  );
                                                },
                                                child: const Icon(
                                                  CupertinoIcons.heart_solid,
                                                  color: Colors.red,
                                                  size: 16,
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  favoriteController
                                                      .addToFavorite(
                                                      favoriteController.favoriteData[
                                                      index]);

                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Product Added To Favorite!",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      backgroundColor:
                                                          Colors.indigo,
                                                      duration:
                                                          Duration(seconds: 1),
                                                    ),
                                                  );
                                                },
                                                child: const Icon(
                                                  CupertinoIcons.heart,
                                                  size: 16,
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        width: size.width,
                                        child: AutoSizeText(
                                          favoriteController
                                              .favoriteData[index].Name,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height / 80,
                                      ),
                                      SizedBox(
                                        width: size.width,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            '₹${favoriteController.favoriteData[index].Price}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height / 80,
                                      ),
                                      SizedBox(
                                        width: size.width,
                                        child: AutoSizeText(
                                          favoriteController.favoriteData[index]
                                              .ShortDescription,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height / 50,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: isAddedInCart
                                                  ? InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        width: size.width,
                                                        height:
                                                            size.height / 20,
                                                        decoration: BoxDecoration(
                                                            color: Colors.pink,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        child: const Center(
                                                            child: Text(
                                                          "Also Add in Cart",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        cartController.addToCart(
                                                            favoriteController
                                                                    .favoriteData[
                                                                index]);
                                                      },
                                                      child: Container(
                                                        width: size.width,
                                                        height:
                                                            size.height / 20,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.indigo,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        child: const Center(
                                                            child: Text(
                                                          "Add to Cart",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                      ),
                                                    ))
                                        ],
                                      )
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
          });
  }
}
