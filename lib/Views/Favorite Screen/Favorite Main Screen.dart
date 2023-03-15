import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/FavoriteListModelClass.dart';
import '../../Controller/Favorite_add_provider.dart';
import '../../Controller/Cart_items_provider.dart';
import '../../Utils/Drawer.dart';
import '../../Utils/Routes_Name.dart';

class FavoriteMainScreen extends StatefulWidget {
  const FavoriteMainScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteMainScreen> createState() => _FavoriteMainScreenState();
}

class _FavoriteMainScreenState extends State<FavoriteMainScreen> {

  @override
  Widget build(BuildContext context) {
    final CartProvider = Provider.of<Purchase_items_provider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: drawerWidget(context, Colors.indigo),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
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
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes_Name.CartMainScreen);
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
                            CartProvider.PurchaseList.length.toString(),
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
      backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: FullList1(context),
          ),
        ),
      ),
    );
  }
  

  Widget FullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FavoriteProvider = Provider.of<Favorite_add_provider>(context);
    final CartProvider = Provider.of<Purchase_items_provider>(context);

    return FavoriteProvider.FavoriteList.isEmpty
        ? Container(
      height: size.height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.0),
              topLeft: Radius.circular(16.0)),
          color: Colors.white
      ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               // Image.asset("assets/oops.png"),
                Image.asset("assets/favourite.gif"),
                const Text(
                  "Not any items added in Favorite ....!",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),

              ],
            ),
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: FavoriteProvider.FavoriteList.length,
            itemBuilder: (context, index) {
              bool isSaved = FavoriteProvider.FavoriteList.any((element) =>
                  element.Name.contains(
                      FavoriteProvider.FavoriteList[index].Name));
              List<dynamic> FavoriteItem = FavoriteProvider.FavoriteList;
              bool isAddedInCart = CartProvider.PurchaseList.any(
                      (element1) => element1.Name.contains(FavoriteProvider.FavoriteList[index].Name));
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Image(
                            image: AssetImage(FavoriteItem[index].ImageURL),
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
                                            setState(() {
                                              FavoriteProvider
                                                  .RemoveFavoriteItems(
                                                      FavoriteProvider
                                                          .FavoriteList[index]);
                                            });

                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Product Remove From Favorite!",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                backgroundColor: Colors.indigo,
                                                duration: Duration(seconds: 1),
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
                                            setState(() {

                                            });

                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Product Added To Favorite!",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                backgroundColor: Colors.indigo,
                                                duration: Duration(seconds: 1),
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
                                    FavoriteItem[index].Name,
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
                                      '₹${FavoriteItem[index].Price}',
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
                                    FavoriteItem[index].ShortDescription,
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
                                          height: size.height / 20,
                                          decoration: BoxDecoration(
                                              color: Colors.pink,
                                              borderRadius:
                                              BorderRadius.circular(5.0)),
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
                                          CartProvider.addItemToCart(
                                              FavoriteListModelClass(
                                                  Price:
                                                  FavoriteItem[index].Price,
                                                  Name: FavoriteItem[index].Name,
                                                  ShortDescription:
                                                  FavoriteItem[index]
                                                      .ShortDescription,
                                                  ImageURL: FavoriteItem[index]
                                                      .ImageURL));
                                        },
                                        child: Container(
                                          width: size.width,
                                          height: size.height / 20,
                                          decoration: BoxDecoration(
                                              color: Colors.indigo,
                                              borderRadius:
                                              BorderRadius.circular(5.0)),
                                          child: const Center(
                                              child: Text(
                                                "Add to Cart",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                    ),
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
  }
}
