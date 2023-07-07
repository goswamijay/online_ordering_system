import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../Controller/ApiConnection/mainDataProvider.dart';
import '../../Controller/Cart_items_provider.dart';
import '../../Controller/ChangeControllerClass.dart';
import '../../Controller/Favorite_add_provider.dart';
import '../../Utils/Drawer.dart';
import '../../Utils/Routes_Name.dart';

class ProductMainScreen extends StatefulWidget {
  const ProductMainScreen({Key? key}) : super(key: key);

  @override
  State<ProductMainScreen> createState() => _ProductMainScreenState();
}

class _ProductMainScreenState extends State<ProductMainScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> searchItems = [];
  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    accessApi(context);
    searchFunction();
  }

  searchFunction() async {
    final apiConnection1 = Provider.of<ApiConnection>(context, listen: false);
    final changeControllerClass =
        Provider.of<ChangeControllerClass>(context, listen: false);

    await apiConnection1.productAllAPI(context);
    changeControllerClass.searchItems = apiConnection1.productAllApi.data;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isFabVisible = true;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isFabVisible = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.values[0]) {
      setState(() {
        _isFabVisible = true;
      });
    }
  }

  void _goToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    setState(() {
      _isFabVisible = false;
    });
  }

  final List<String> imgList = [
    'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
    'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
    'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
  ];
  List<dynamic> mainData = [];
  String cartItem = '';
  accessApi(BuildContext context) async {
    final apiConnection1 = Provider.of<ApiConnection>(context, listen: false);
    apiConnection1.showItemBool = false;

    await apiConnection1.productAllAPI(context);
    _isFabVisible = false;
    mainData = apiConnection1.productAllApi.data;

    //mainData = apiConnection1.productAllApi.data.map((e) => e).toList();
    apiConnection1.showItem();
    cartItem = apiConnection1.productAllApi.totalProduct.toString();
  }

  searchBar(String value) {
    final changeControllerClass =
        Provider.of<ChangeControllerClass>(context, listen: false);
    final apiConnection1 = Provider.of<ApiConnection>(context, listen: false);
    {
      changeControllerClass.searchButtonPress();

      if (value.isEmpty) {
        changeControllerClass.searchButtonUnPress();
      }

      List<dynamic> result = [];
      if (value.isEmpty) {
        result = apiConnection1.productAllApi.data;
      } else {
        setState(() {
          result = apiConnection1.productAllApi.data
              .where((element) => element.title
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()))
              .toList();
        });
      }

      if (result.isEmpty) {
        changeControllerClass.listIsEmpty();
      } else {
        changeControllerClass.listNotEmpty();
      }
      changeControllerClass.searchItems = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final changeControllerClass = Provider.of<ChangeControllerClass>(context);
    final apiConnection1 = Provider.of<ApiConnection>(context);

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerWidget(),
        backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 12.0),
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
                            child: apiConnection1.showItemBool == false
                                ? const Text(
                                    '0',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    apiConnection1.productAllApi.totalProduct
                                            .toString() ??
                                        '',
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
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Consumer<ChangeControllerClass>(
                                  builder: (context, value, child) {
                                return CupertinoSearchTextField(
                                  backgroundColor: Colors.white,
                                  itemSize: size.height / 33,
                                  controller: changeControllerClass.controller,
                                  onChanged: (value) {
                                    searchBar(value);
                                  },
                                  onSuffixTap: () {
                                    changeControllerClass.searchButtonUnPress();
                                    changeControllerClass.controller.clear();
                                  },
                                  onSubmitted: (value) {},
                                  autocorrect: true,
                                );
                              }),
                            ),
                            SizedBox(
                              width: size.width / 80,
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
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
                              height: 180,
                              onPageChanged: (index, reason) {
                                changeControllerClass.photoIndex(index);
                              }),
                          items: imgList
                              .map((item) => Center(
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
                          height: size.height / 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
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
                        apiConnection1.showItemBool
                            ? Center(
                                child: !changeControllerClass.searchButton
                                    ? fullList1(context)
                                    : customList1(context),
                              )
                            : const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: _isFabVisible
            ? CircleAvatar(
                backgroundColor: Colors.pink,
                child: InkWell(
                  onTap: _goToTop,
                  child: const Icon(
                    Icons.arrow_upward_sharp,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  Widget customList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final favoriteProvider = Provider.of<FavoriteAddProvider>(context);
    final changeControllerClass = Provider.of<ChangeControllerClass>(context);
    final cartProvider = Provider.of<cart_items_provider>(context);
    final mainDataProvider = Provider.of<ApiConnection>(context);

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
              return InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushNamed(context, Routes_Name.ProductDetailsScreen,
                      arguments: {
                        'Price': changeControllerClass.searchItems[index].price,
                        'Name': changeControllerClass.searchItems[index].title,
                        'ImageURL':
                            changeControllerClass.searchItems[index].imageUrl,
                        'ShortDescription': changeControllerClass
                            .searchItems[index].description,
                        'Index': index,
                      });
                },
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: AspectRatio(
                            aspectRatio: 1,
                            child: Image(
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                    child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                              .toInt()
                                      : null,
                                ));
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                );
                              },
                              image: NetworkImage(changeControllerClass
                                  .searchItems[index].imageUrl
                                  .replaceAll('(', '')
                                  .replaceAll(')', '')),
                              width: size.width / 2,
                              height: size.height / 5,
                            ),
                          )),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 5.0, bottom: 8.0, top: 8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: changeControllerClass
                                                .searchItems[index]
                                                .watchListItemId !=
                                            ''
                                        ? InkWell(
                                            onTap: () async {
                                              await favoriteProvider
                                                  .removeFavorite(
                                                      changeControllerClass
                                                          .searchItems[index]
                                                          .watchListItemId);

                                              Future.delayed(
                                                  const Duration(seconds: 0),
                                                  () async {
                                                changeControllerClass.controller
                                                    .clear();
                                                changeControllerClass
                                                    .searchButtonUnPress();

                                                await searchFunction();
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
                                              });
                                            },
                                            child: const Icon(
                                              CupertinoIcons.heart_solid,
                                              color: Colors.red,
                                              size: 16,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              await favoriteProvider
                                                  .addInFavorite(
                                                      changeControllerClass
                                                          .searchItems[index]
                                                          .id);

                                              Future.delayed(
                                                  const Duration(seconds: 0),
                                                  () async {
                                                changeControllerClass.controller
                                                    .clear();
                                                changeControllerClass
                                                    .searchButtonUnPress();

                                                await searchFunction();

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
                                              });
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
                                          .searchItems[index].title,
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
                                        '\$${changeControllerClass.searchItems[index].price}',
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
                                      changeControllerClass
                                          .searchItems[index].description,
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
                                        child: changeControllerClass
                                                    .searchItems[index]
                                                    .quantity !=
                                                0
                                            ? Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
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
                                                          "Added in Cart",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            await cartProvider.decreaseProductQuantity(
                                                                changeControllerClass
                                                                    .searchItems[
                                                                        index]
                                                                    .cartItemId);

                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 0),
                                                                () async {
                                                              changeControllerClass
                                                                  .controller
                                                                  .clear();
                                                              changeControllerClass
                                                                  .searchButtonUnPress();

                                                              await searchFunction();
                                                            });
                                                          },
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[200],
                                                            // Colors.pink[500],
                                                            radius: 14,
                                                            child: const Center(
                                                                child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                          ),
                                                        ),
                                                        Text(
                                                          changeControllerClass
                                                              .searchItems[
                                                                  index]
                                                              .quantity
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            await cartProvider.increaseProductQuantity(
                                                                changeControllerClass
                                                                    .searchItems[
                                                                        index]
                                                                    .cartItemId);

                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 0),
                                                                () async {
                                                              changeControllerClass
                                                                  .controller
                                                                  .clear();
                                                              changeControllerClass
                                                                  .searchButtonUnPress();

                                                              await searchFunction();
                                                            });
                                                          },
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[200],
                                                            radius: 14,
                                                            child: const Center(
                                                                child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : InkWell(
                                                onTap: () async {
                                                  await cartProvider
                                                      .productAllAPI(
                                                          changeControllerClass
                                                              .searchItems[
                                                                  index]
                                                              .id);
                                                  changeControllerClass
                                                      .controller
                                                      .clear();
                                                  changeControllerClass
                                                      .searchButtonUnPress();

                                                  await searchFunction();
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
    Size size = MediaQuery.of(context).size;
    final favoriteProvider = Provider.of<FavoriteAddProvider>(context);
    final cartProvider = Provider.of<cart_items_provider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        // Add your refresh logic here
        await accessApi(context);
      },
      child: mainData.isEmpty
          ? Column(
              children: const [Text("No any Items")],
            )
          : Consumer<ApiConnection>(builder: (index, mainDataProvider, child) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: mainData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes_Name.ProductDetailsScreen,
                            arguments: {
                              'Price': mainData[index].price,
                              'Name': mainData[index].title,
                              'ImageURL': mainData[index].imageUrl,
                              'ShortDescription': mainData[index].description,
                              'Index': index,
                            });
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image(
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                          child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                                    .toInt()
                                            : null,
                                      ));
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                    image: NetworkImage(mainData[index]
                                        .imageUrl
                                        .replaceAll('(', '')
                                        .replaceAll(')', '')),
                                    width: size.width / 2,
                                    height: size.height / 5,
                                  ),
                                )),
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
                                          child: mainDataProvider
                                                      .productAllApi
                                                      .data[index]
                                                      .watchListItemId !=
                                                  ''
                                              ? InkWell(
                                                  onTap: () async {
                                                    await favoriteProvider
                                                        .removeFavorite(
                                                            mainDataProvider
                                                                .productAllApi
                                                                .data[index]
                                                                .watchListItemId);

                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 0),
                                                        () async {
                                                      await mainDataProvider
                                                          .productAllAPI(
                                                              context);
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
                                                    CupertinoIcons.heart_solid,
                                                    color: Colors.red,
                                                    size: 16,
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    await favoriteProvider
                                                        .addInFavorite(
                                                            mainDataProvider
                                                                .productAllApi
                                                                .data[index]
                                                                .id);

                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 0),
                                                        () async {
                                                      await mainDataProvider
                                                          .productAllAPI(
                                                              context);
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
                                                    });
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
                                            mainData[index].title,
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
                                              '\$${mainData[index].price}',
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
                                            mainData[index].description,
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
                                              child:
                                                  mainDataProvider
                                                              .productAllApi
                                                              .data[index]
                                                              .quantity !=
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  width: size
                                                                      .width,
                                                                  height:
                                                                      size.height /
                                                                          20,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .pink,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0)),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    "Added in Cart",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await cartProvider.decreaseProductQuantity(mainDataProvider
                                                                          .productAllApi
                                                                          .data[
                                                                              index]
                                                                          .cartItemId);

                                                                      Future.delayed(
                                                                          const Duration(
                                                                              milliseconds: 0),
                                                                          () async {
                                                                        await mainDataProvider
                                                                            .productAllAPI(context);
                                                                      });
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[200],
                                                                      // Colors.pink[500],
                                                                      radius:
                                                                          14,
                                                                      child: const Center(
                                                                          child: Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    mainDataProvider
                                                                        .productAllApi
                                                                        .data[
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await cartProvider
                                                                          .increaseProductQuantity(
                                                                              mainData[index].cartItemId);

                                                                      Future.delayed(
                                                                          const Duration(
                                                                              milliseconds: 0),
                                                                          () async {
                                                                        await mainDataProvider
                                                                            .productAllAPI(context);
                                                                      });
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[200],
                                                                      radius:
                                                                          14,
                                                                      child: const Center(
                                                                          child: Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : InkWell(
                                                          onTap: () async {
                                                            await cartProvider
                                                                .productAllAPI(
                                                                    mainData[index]
                                                                        .id);

                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        0),
                                                                () async {
                                                              await mainDataProvider
                                                                  .productAllAPI(
                                                                      context);
                                                            });
                                                          },
                                                          child: Container(
                                                            width: size.width,
                                                            height:
                                                                size.height /
                                                                    20,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .indigo,
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
                  });
            }),
    );
  }
}
