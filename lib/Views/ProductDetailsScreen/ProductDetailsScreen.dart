import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Cart_items_provider.dart';
import '../../Controller/Favorite_add_provider.dart';
import '../../Models/FavoriteListModelClass.dart';
import '../../Utils/Routes_Name.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Map<String,dynamic>? argument = {};

  @override
  Widget build(BuildContext context) {
    final FavoriteProvider = Provider.of<Favorite_add_provider>(context);
    final CartProvider = Provider.of<Purchase_items_provider>(context);
      argument = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    Size size = MediaQuery.of(context).size;

    bool isSaved = FavoriteProvider.FavoriteList.any(
            (element) => element.Name.contains( argument!['Name']));
    bool isAddedInCart = CartProvider.PurchaseList.any(
            (element1) => element1.Name.contains( argument!['Name']));
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0,right: 12.0),
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
                    Navigator.pushNamed(
                        context, Routes_Name.CartMainScreen);
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
                                CartProvider.PurchaseList.length
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white),
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
                    width:  size.width ,
                      height: size.height / 2,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Image(
                      image: AssetImage(argument!['ImageURL']),
                      // image: AssetImage('first.jpg'),
                      width: size.width / 2,
                      height: size.height / 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: isSaved
                          ? InkWell(
                        onTap: () {
                          setState(() {
                            FavoriteProvider
                                .RemoveFavoriteItems(
                                FavoriteProvider
                                    .FavoriteList[argument!['Index']]);
                          });

                          ScaffoldMessenger.of(context)
                              .hideCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
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
                          setState(() {
                            FavoriteProvider.AddFavoriteItems(
                                FavoriteListModelClass(
                                    Price:
                                    argument!['Price'],
                                    Name: argument!['Name'],
                                    ShortDescription:
                                    argument!['ShortDescription'],
                                    ImageURL: argument!['ImageURL'],
                                    Count: 1));
                            print(FavoriteProvider
                                .FavoriteList.length);
                          });

                          ScaffoldMessenger.of(context)
                              .hideCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
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

            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SizedBox(
                width: size.width,
                child: AutoSizeText(
                  argument!['Name'].toString(),
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 30),
                ),
              ),
            ),
            SizedBox(
              height: size.height/60  ,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: SizedBox(
                width: size.width,
                child: AutoSizeText(
                  argument!['ShortDescription'].toString(),
                  maxLines: 4,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20),
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
            Expanded(child: SizedBox(
              width: size.width,
              child: AutoSizeText('₹${argument!['Price']}',
                maxLines: 1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),),
            Expanded(
              flex: 2,
              child:  isAddedInCart
                  ? InkWell(
                onTap: () {},
                child: Container(
                  width: size.width,
                  height: size.height / 15,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius:
                      BorderRadius.circular(
                          5.0)),
                  child: const Center(
                      child: Text(
                        "Also Add in Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold),
                      )),
                ),
              )
                  : InkWell(
                onTap: () {
                  CartProvider.addItemToCart(
                      FavoriteListModelClass(
                          Price:
                         argument!['Price'],
                          Name:
                          argument!['Name'],
                          ShortDescription:
                          argument!['ShortDescription'],
                          ImageURL: argument!['ImageURL'],
                          Count: 1));
                },
                child: Container(
                  width: size.width,
                  height: size.height / 15,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius:
                      BorderRadius.circular(
                          5.0)),
                  child: const Center(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold),
                      )),
                ),
              ),)
          ],
        ),
      ),
    );
  }
}
