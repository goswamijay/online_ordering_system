import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Controller/ApiConnection/ApiConnection.dart';
import 'package:online_ordering_system/Controller/ApiConnection/Authentication.dart';
import 'package:provider/provider.dart';

import '../../Controller/Cart_items_provider.dart';
import '../../Controller/Favorite_add_provider.dart';
import '../../Utils/Routes_Name.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Map<String, dynamic>? argument = {};

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteAddProvider>(context);
    final cartProvider = Provider.of<purchase_items_provider>(context);
    final mainDataProvider = Provider.of<ApiConnection>(context);
    argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Size size = MediaQuery.of(context).size;

    bool isSaved = false;
    /* favoriteProvider.FavoriteList.any(
            (element) => element.Name.contains( argument!['Name']));*/
    bool isAddedInCart = cartProvider.purchaseList
        .any((element1) => element1.Name.contains(argument!['Name']));
    return SafeArea(
      child: Scaffold(
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
                                      shape: BoxShape.circle,
                                      color: Colors.red[900]),
                                  width: 34 / 2,
                                  height: 34 / 2,
                                  child: Text(
                                    cartProvider.purchaseList.length.toString(),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height / 2,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Image(
                        image: NetworkImage(argument!['ImageURL']),
                        // image: AssetImage('first.jpg'),
                        width: size.width / 2,
                        height: size.height / 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: mainDataProvider.productAll[0]
                                    .data[argument!['Index']].watchListItemId !=
                                ''
                            ? InkWell(
                                onTap: () async {
                                  await favoriteProvider.removeFavorite(
                                      mainDataProvider
                                          .productAll[0]
                                          .data[argument!['Index']]
                                          .watchListItemId);

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
                                onTap: () async {
                                  await favoriteProvider.addInFavorite(
                                      mainDataProvider.productAll[0]
                                          .data[argument!['Index']].id);

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
                      height: size.height / 20,
                      width: size.width,
                    ),
                  ),
                  Expanded(
                    child: Image.network(
                      'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
                      height: size.height / 20,
                      width: size.width,
                    ),
                  ),
                  Expanded(
                    child: Image.network(
                      'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
                      height: size.height / 20,
                      width: size.width,
                    ),
                  ),
                  Expanded(
                      child: Image.network(
                    'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
                    height: size.height / 20,
                    width: size.width,
                  )),
                ],
              ),
              SizedBox(
                height: size.height / 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: size.width,
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
                height: size.height / 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                child: SizedBox(
                  width: size.width,
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
                  width: size.width,
                  child: AutoSizeText(
                    '\$${argument!['Price']}',
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: mainDataProvider
                            .productAll[0].data[argument!['Index']].quantity !=
                        0
                    ? InkWell(
                        onTap: () {},
                        child: Container(
                          width: size.width,
                          height: size.height / 15,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                              child: Text(
                            "Also Add in Cart",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    : InkWell(
                        onTap: () {},
                        child: Container(
                          width: size.width,
                          height: size.height / 15,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                              child: Text(
                            "Add to Cart",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
