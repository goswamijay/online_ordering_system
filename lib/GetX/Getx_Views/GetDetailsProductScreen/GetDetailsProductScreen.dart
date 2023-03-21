import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Models/GetxProductModel.dart';

import '../../Getx_Controller/GetxCartController.dart';
import '../../Getx_Controller/GetxFavoriteController.dart';

class GetDetailsProductScreen extends StatefulWidget {
  const GetDetailsProductScreen({Key? key}) : super(key: key);

  @override
  State<GetDetailsProductScreen> createState() =>
      _GetDetailsProductScreenState();
}

class _GetDetailsProductScreenState extends State<GetDetailsProductScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic argument = Get.arguments;

    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());

    return GetBuilder<GetxFavoriteController>(builder: (controller) {
      return GetBuilder<GetxCartController>(builder: (controller) {
        bool isSaved = favoriteController.favoriteData
            .any((element) => element.Name.contains(argument!['Name']));
        bool isAddedInCart = cartController.cartData
            .any((element1) => element1.Name.contains(argument!['Name']));
        return Scaffold(
          backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.black,
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          /*Navigator.pushNamed(
                              context, Routes_Name.CartMainScreen);*/
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
                                        shape: BoxShape.circle,
                                        color: Colors.red[900]),
                                    width: 34 / 2,
                                    height: 34 / 2,
                                    child: Text(
                                      cartController.cartData.length.toString(),
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Stack(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height / 2,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Image(
                          image: AssetImage(argument!['ImageURL']),
                          // image: AssetImage('first.jpg'),
                          width: Get.width / 2,
                          height: Get.height / 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: isSaved
                              ? InkWell(
                                  onTap: () {
                                    favoriteController.removeToFavorite(
                                        favoriteController
                                            .favoriteData[argument!['Index']]);
                                    /*  setState(() {
                                  FavoriteProvider
                                      .RemoveFavoriteItems(
                                      FavoriteProvider
                                          .FavoriteList[argument!['Index']]);
                                });
*/
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Product Remove From Favorite!",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        backgroundColor: Colors.indigo,
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    CupertinoIcons.heart_solid,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    favoriteController.addToFavorite(
                                        GetxProduct(
                                            Price: argument!['Price'],
                                            Name: argument!['Name'],
                                            ShortDescription:
                                                argument!['ShortDescription'],
                                            ImageURL: argument!['ImageURL']));

                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Product Added To Favorite!",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        backgroundColor: Colors.indigo,
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    CupertinoIcons.heart,
                                    size: 20,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
                        height: Get.height / 10,
                        width: Get.width,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
                        height: Get.height / 10,
                        width: Get.width,
                      ),
                    ),
                    Expanded(
                      child: Image.network(
                        'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
                        height: Get.height / 10,
                        width: Get.width,
                      ),
                    ),
                    Expanded(
                        child: Image.network(
                      'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
                      height: Get.height / 10,
                      width: Get.width,
                    )),
                  ],
                ),
                SizedBox(
                  height: Get.height / 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: Get.width,
                          child: AutoSizeText(
                            argument!['Name'].toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 30),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Text("4.5"),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[900],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height / 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                  child: SizedBox(
                    width: Get.width,
                    child: AutoSizeText(
                      argument!['ShortDescription'].toString(),
                      maxLines: 4,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: Get.width,
                    child: AutoSizeText(
                      '₹${argument!['Price']}',
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: isAddedInCart
                      ? InkWell(
                          onTap: () {},
                          child: Container(
                            width: Get.width,
                            height: Get.height / 15,
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Center(
                                child: Text(
                              "Also Add in Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            cartController.addToCart(GetxProduct(
                                Price: argument!['Price'],
                                Name: argument!['Name'],
                                ShortDescription: argument!['ShortDescription'],
                                ImageURL: argument!['ImageURL']));
                          },
                          child: Container(
                            width: Get.width,
                            height: Get.height / 15,
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Center(
                                child: Text(
                              "Add to Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      });
    });
  }
}
