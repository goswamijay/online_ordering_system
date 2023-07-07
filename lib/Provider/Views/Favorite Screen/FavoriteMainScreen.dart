import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/ApiConnection/mainDataProvider.dart';
import '../../Controller/Cart_items_provider.dart';
import '../../Controller/Favorite_add_provider.dart';
import '../../Utils/Drawer.dart';
import '../../Utils/Routes_Name.dart';

class FavoriteMainScreen extends StatefulWidget {
  const FavoriteMainScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteMainScreen> createState() => _FavoriteMainScreenState();
}

class _FavoriteMainScreenState extends State<FavoriteMainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      accessApi(context);
    });
  }

  List<dynamic> favoriteData = [];
  accessApi(BuildContext context) async {
    final apiConnection1 =
        Provider.of<FavoriteAddProvider>(context, listen: false);

    final cartProvider =
        Provider.of<cart_items_provider>(context, listen: false);
    apiConnection1.showItemBool = false;
    cartProvider.showItemBool = false;

    await apiConnection1.favoriteAllDataAPI(context);
    await cartProvider.cartAllDataAPI(context);

    apiConnection1.showItem();
    cartProvider.showItem();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        Provider.of<FavoriteAddProvider>(context, listen: false);
    final cartProvider = Provider.of<cart_items_provider>(context);

    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 12.0),
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
                          child: favoriteProvider.showItemBool
                              ? Text(
                                  cartProvider.addCartItem[0].data.length
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
      backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: fullList1(context),
        ),
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final favoriteProvider = Provider.of<FavoriteAddProvider>(context);
    final mainData = Provider.of<ApiConnection>(context);

    return Center(
      child: favoriteProvider.showItemBool
          ? favoriteProvider.favoriteData.data.isEmpty
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
                  //physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: favoriteProvider.favoriteData.data.length,
                  itemBuilder: (context, index) {
                    if (favoriteProvider.favoriteData.data[index].productDetails
                        .imageUrl.isEmpty) {
                      return Container();
                    } else {
                      return InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes_Name.ProductDetailsScreen,
                              arguments: {
                                'Price': favoriteProvider.favoriteData
                                    .data[index].productDetails.price,
                                'Name': favoriteProvider.favoriteData
                                    .data[index].productDetails.title,
                                'ImageURL': favoriteProvider.favoriteData
                                    .data[index].productDetails.imageUrl,
                                'ShortDescription': favoriteProvider
                                    .favoriteData
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
                                    child: Image(
                                      image: NetworkImage(favoriteProvider
                                          .favoriteData
                                          .data[index]
                                          .productDetails
                                          .imageUrl),
                                      fit: BoxFit.fitWidth,
                                      width: size.width / 2,
                                      height: size.height / 5,
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
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: favoriteProvider.favoriteData
                                                        .data[index].id !=
                                                    ''
                                                ? InkWell(
                                                    onTap: () async {
                                                      await favoriteProvider
                                                          .removeFavorite(
                                                              favoriteProvider
                                                                  .favoriteData
                                                                  .data[index]
                                                                  .id);

                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 0), () {
                                                        //   accessApi(context);
                                                        favoriteProvider
                                                            .favoriteAllDataAPI(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .hideCurrentSnackBar();
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              "Product Remove From Favorite!",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                            backgroundColor:
                                                                Colors.indigo,
                                                            duration: Duration(
                                                                seconds: 1),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: const Icon(
                                                      CupertinoIcons
                                                          .heart_solid,
                                                      color: Colors.red,
                                                      size: 16,
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () async {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "Product Added To Favorite!",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          backgroundColor:
                                                              Colors.indigo,
                                                          duration: Duration(
                                                              seconds: 1),
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
                                              favoriteProvider
                                                  .favoriteData
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
                                            height: size.height / 90,
                                          ),
                                          SizedBox(
                                            width: size.width,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                '\$${favoriteProvider.favoriteData.data[index].productDetails.price}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height / 90,
                                          ),
                                          SizedBox(
                                            width: size.width,
                                            child: AutoSizeText(
                                              favoriteProvider
                                                  .favoriteData
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
                                            height: size.height / 60,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: mainData
                                                            .productAllApi
                                                            .data[index]
                                                            .quantity !=
                                                        0
                                                    ? InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          width: size.width,
                                                          height:
                                                              size.height / 20,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.pink,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                          child: const Center(
                                                              child: Text(
                                                            "Also Add in Cart",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {},
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
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                        ),
                      );
                    }
                  })
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
