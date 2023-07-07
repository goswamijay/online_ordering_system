import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/ApiConnection/mainDataProvider.dart';
import '../../Controller/Cart_items_provider.dart';
import '../../Controller/ChangeControllerClass.dart';
import '../../Controller/Favorite_add_provider.dart';
import '../../Models/FavoriteListModelClass.dart';
import '../../Models/ProductListModelClass.dart';
import '../../Utils/Drawer.dart';
import '../../Utils/Routes_Name.dart';

class ProductMainScreen2 extends StatefulWidget {
  const ProductMainScreen2({Key? key}) : super(key: key);

  @override
  State<ProductMainScreen2> createState() => _ProductMainScreen2State();
}

class _ProductMainScreen2State extends State<ProductMainScreen2>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> searchItems = [];


  @override
  void initState() {
    // TODO: implement initState
    searchItems = mainData;
    // _tabController = TabController(vsync: this, length: 11);
    super.initState();
    accessApi(context);
  }

  final List<String> imgList = [
    'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
    'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
    'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
  ];
  List<dynamic> mainData = [];

  accessApi(BuildContext context) async {
    final apiConnection1 = Provider.of<ApiConnection>(context, listen: false);

   // apiConnection1.productAllAPI11();
    apiConnection1.showItem();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<cart_items_provider>(context);
    final changeControllerClass = Provider.of<ChangeControllerClass>(context);
    final apiConnection1 = Provider.of<ApiConnection>(context);

    String totalItem = "";

    Future.delayed(Duration(seconds: 3), () {
      totalItem = cartProvider.addCartItem[0].data.length.toString() ?? '0';
    });

    Size size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerWidget(),
        backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.menu,
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
                                            cartProvider.addCartItem[0].data
                                                .length.toString() ?? '0',
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
                        SizedBox(
                          height: size.height / 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Consumer<ChangeControllerClass>(
                                  builder: (context, value, child) {
                                    return CupertinoSearchTextField(
                                      backgroundColor: Colors.white,
                                      itemSize: size.height / 33,
                                      controller: changeControllerClass
                                          .controller,
                                      onChanged: (value) {
                                        changeControllerClass
                                            .searchButtonPress();

                                        if (value.isEmpty) {
                                          changeControllerClass
                                              .searchButtonUnPress();
                                        }

                                        List<dynamic> result = [];
                                        if (value.isEmpty) {
                                          result = mainData;
                                        } else {
                                          result = mainData
                                              .where((element) =>
                                              element.Name.toString()
                                                  .toLowerCase()
                                                  .contains(
                                                  value.toLowerCase()))
                                              .toList();
                                        }

                                        if (result.isEmpty) {
                                          changeControllerClass.listIsEmpty();
                                        } else {
                                          changeControllerClass.listNotEmpty();
                                        }
                                        changeControllerClass.searchItems =
                                            result;
                                      },
                                      onSuffixTap: () {
                                        changeControllerClass
                                            .searchButtonUnPress();
                                        changeControllerClass.controller
                                            .clear();
                                      },
                                      onSubmitted: (value) {},
                                      autocorrect: true,
                                    );
                                  }),
                            ),
                            SizedBox(
                              width: size.width / 60,
                            ),
                            Container(
                                height: size.height / 25,
                                width: size.width / 16,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.line_horizontal_3_decrease,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: size.height / 50,
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                              height: 200,
                              onPageChanged: (index, reason) {
                                changeControllerClass.photoIndex(index);
                              }),
                          items: imgList
                              .map((item) =>
                              Center(
                                  child: Image.network(item,
                                      fit: BoxFit.cover,
                                      width: size.width / 1.1)))
                              .toList(),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imgList.map((e) {
                              int index = imgList.indexOf(e);
                              return Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                  changeControllerClass.photoIndex1 == index
                                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                                      : const Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                              );
                            }).toList()),
                        SizedBox(
                          height: size.height / 100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                !changeControllerClass.searchButton
                                    ? "Best Selling"
                                    : "Search List",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )),
                        ),
                        SizedBox(
                          height: size.height / 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                          child: apiConnection1.showItemBool
                              ? Center(
                            child: !changeControllerClass.searchButton
                                ? fullList1(context)
                                : customList1(context),
                          )
                              : const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customList1(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final favoriteProvider = Provider.of<FavoriteAddProvider>(context);
    final cartProvider = Provider.of<cart_items_provider>(context);
    final changeControllerClass = Provider.of<ChangeControllerClass>(context);

    return changeControllerClass.listIsEmpty1
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/oops.png"),
          const Text(
            "Search Item is not available ....!",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    )
        : ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: changeControllerClass.searchItems.length,
        itemBuilder: (context, index) {
          bool isSaved = false;
          /* favoriteProvider.favoriteData.any((element) =>
              element.Name.contains(
                  changeControllerClass.searchItems[index].Name));*/
          bool isAddedInCart1 = cartProvider.purchaseList.any((element1) =>
              element1.Name.contains(
                  changeControllerClass.searchItems[index].Name));

          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(context, Routes_Name.ProductDetailsScreen,
                  arguments: {
                    'Price': changeControllerClass.searchItems[index].Price,
                    'Name': changeControllerClass.searchItems[index].Name,
                    'ImageURL':
                    changeControllerClass.searchItems[index].ImageURL,
                    'ShortDescription': changeControllerClass
                        .searchItems[index].ShortDescription,
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
                          image: AssetImage(changeControllerClass
                              .searchItems[index].ImageURL),
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
                                    /* favoriteProvider
                                        .RemoveFavoriteItems(
                                        favoriteProvider
                                            .FavoriteList[index]);*/

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
                                  changeControllerClass
                                      .searchItems[index].Name,
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
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '₹${changeControllerClass.searchItems[index]
                                        .Price}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height / 70,
                              ),
                              SizedBox(
                                width: size.width,
                                child: AutoSizeText(
                                  changeControllerClass
                                      .searchItems[index].ShortDescription,
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
                                    child: isAddedInCart1
                                        ? InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: size.width,
                                        height: size.height / 20,
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

                                      },
                                      child: Container(
                                        width: size.width,
                                        height: size.height / 20,
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
        });
  }

  Widget tabItemWidget1(String logo, String name) {
    return Tab(
      height: 75,
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints.expand(width: 50),
        child: Column(
          children: [
            CircleAvatar(backgroundImage: ExactAssetImage(logo)),
            const SizedBox(
              height: 10,
            ),
            AutoSizeText(
              name,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    return Container();
    /* Size size = MediaQuery.of(context).size;
    final favoriteProvider = Provider.of<FavoriteAddProvider>(context);
    final cartProvider = Provider.of<purchase_items_provider>(context);
    final apiConnection1 = Provider.of<ApiConnection>(context);

    return apiConnection1.productAllAPI1.data.isEmpty
        ? Column(
      children: const [Text("No any Items")],
    )
        : ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: apiConnection1.productAllAPI1.data.length,
        itemBuilder: (context, index) {
          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(context, Routes_Name.ProductDetailsScreen,
                  arguments: {
                    'Price': mainData[index].Price,
                    'Name': mainData[index].Name,
                    'ImageURL': mainData[index].ImageURL,
                    'ShortDescription': mainData[index].ShortDescription,
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
                          image: NetworkImage(

                              apiConnection1.productAllAPI1.data[index].imageUrl.replaceAll('(', '')
                                  .replaceAll(')', '')

                          ),
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
                                child: apiConnection1.productAll[0]
                                    .data[index].watchListItemId !=
                                    ''
                                    ? InkWell(
                                  onTap: () {
                                    favoriteProvider.removeFavorite(
                                        mainData[0]
                                            .data[index]
                                            .watchListItemId);

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
                                    favoriteProvider.addInFavorite(
                                        mainData[0].data[index].id);

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

                                  apiConnection1.productAllAPI1.data[index].title,
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
                                    '\$${
                                        apiConnection1.productAllAPI1.data[index].price}',
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

                                  apiConnection1.productAllAPI1.data[index].description,
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
                                    child: apiConnection1.productAll[0]
                                        .data[index].quantity !=
                                        0
                                        ? InkWell(
                                      onTap: () {
                                        */ /*   cartProvider.PurchaseList[index]
                                                  .Count++;
                                              print(cartProvider
                                                  .PurchaseList[index].Count);*/ /*
                                      },
                                      child: Container(
                                        width: size.width,
                                        height: size.height / 20,
                                        decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.0)),
                                        child: const Center(
                                            child: Text(
                                              "Added in Cart :- 1 ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            )),
                                      ),
                                    )
                                        : InkWell(
                                      onTap: () {
                                        cartProvider.productAllAPI(
                                            mainData[0]
                                                .data[index]
                                                .id);
                                      },
                                      child: Container(
                                        width: size.width,
                                        height: size.height / 20,
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
        });
  }*/
  }
}

