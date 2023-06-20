import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Controller/GetxFavoriteController.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Getx_Controller/GetxCartController.dart';
import '../../Getx_Controller/GetxControllerClass.dart';
import '../../Getx_Controller/GetxProductController.dart';
import '../../Getx_Utils/GetDrawer.dart';

class GetProductMainScreen extends StatefulWidget {
  const GetProductMainScreen({Key? key}) : super(key: key);

  @override
  State<GetProductMainScreen> createState() => _GetProductMainScreenState();
}

class _GetProductMainScreenState extends State<GetProductMainScreen>
    with TickerProviderStateMixin {
  final productController = Get.put(GetxProductController());
  final cartController = Get.put(GetxCartController());
  GetControllerClass buttonController = Get.put(GetControllerClass());

  TextEditingController search = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  List<dynamic> searchItems = [];
  int currentIndex = 0;
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchItemChange();
    _tabController = TabController(vsync: this, length: 3);
    productController.productAllAPI();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  searchItemChange() {
    searchItems = productController.getProductAllAPI.data;
  }

  void appleListData(String text) {
    text = 'apple';
    List<dynamic> result = [];
    if (text.isEmpty) {
      result = productController.getProductAllAPI.data;
    } else {
      result = productController.getProductAllAPI.data
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }

    if (result.isEmpty) {
      buttonController.listIsEmpty.value = true;
    } else {
      buttonController.listIsEmpty.value = false;
    }
    searchItems = result;
  }

  void onSearchTextChanged(String text) {
    List<dynamic> result = [];
    if (text.isEmpty) {
      result = productController.getProductAllAPI.data;
    } else {
      result = productController.getProductAllAPI.data
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }

    if (result.isEmpty) {
      buttonController.listIsEmpty.value = true;
    } else {
      buttonController.listIsEmpty.value = false;
    }
    searchItems = result;
  }

  final List<String> imgList = [
    'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
    'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
    'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
  ];

  final List locale1 = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'عربي', 'locale': const Locale('ar', 'AA')},


  ];

  saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    String localeString = jsonEncode({
      'languageCode': locale.languageCode,
      'countryCode': locale.countryCode,
    });
    await prefs.setString('locale', localeString);
  }

  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: () async {
            final now = DateTime.now();
            if (_lastPressedAt == null ||
                now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
              _lastPressedAt = now;
              Get.rawSnackbar(
                messageText: const Text(
                  'Press back again to exit',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(CupertinoIcons.back),
                backgroundColor: Colors.white,
                //colorText: Colors.black,
                snackPosition: SnackPosition.BOTTOM,
              );
              return false;
            }
            return true;
          },
          child: Scaffold(
            key: _scaffoldKey,
            drawer: const GetDrawerWidget(),
            // backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
            appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                    child: GetBuilder<GetxProductController>(
                        builder: (controller) {
                      return InkWell(
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
                                        shape: BoxShape.circle,
                                        color: Colors.red[900]),
                                    width: 34 / 2,
                                    height: 34 / 2,
                                    child: Text(
                                      productController
                                          .getProductAllAPI.totalProduct
                                          .toString(),
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
                      );
                    }),
                  )
                ]),
            body: SingleChildScrollView(
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
                                  child: CupertinoSearchTextField(
                                    backgroundColor: Colors.white,
                                    itemSize: Get.height / 33,
                                    controller: searchController,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        buttonController.searchButton.value =
                                            false;
                                        setState(() {});
                                      } else {
                                        buttonController.searchButton.value =
                                            true;
                                        onSearchTextChanged(value);
                                        setState(() {});
                                      }
                                    },
                                    onSuffixTap: () {
                                      buttonController.searchButton.value =
                                          false;
                                      searchController.clear();
                                      setState(() {});
                                    },
                                    onSubmitted: (value) {},
                                    autocorrect: true,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / 80,
                                ),
                                InkWell(
                                  onTap: () => {
                                    buildDialog(context),
                                  },
                                  child: Container(
                                    height: Get.height / 25,
                                    width: Get.width / 16,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.black),
                                    child: const Icon(
                                      Icons.translate_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Get.height / 50,
                            ),
                            GetBuilder<GetControllerClass>(
                                builder: (buttonController) {
                              return CarouselSlider(
                                options: CarouselOptions(
                                    aspectRatio: 2.0,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                    height: 180,
                                    onPageChanged: (index, reason) {
                                      buttonController.updateIndex(index);
                                    }),
                                items: imgList
                                    .map((item) => Center(
                                        child: Image.network(item,
                                            fit: BoxFit.cover,
                                            width: Get.width / 1.1)))
                                    .toList(),
                              );
                            }),
                            GetBuilder<GetControllerClass>(
                                builder: (buttonController) {
                              return Row(
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
                                        color: buttonController.photoIndex1 ==
                                                index
                                            ? const Color.fromRGBO(0, 0, 0, 0.9)
                                            : const Color.fromRGBO(
                                                0, 0, 0, 0.4),
                                      ),
                                    );
                                  }).toList());
                            }),
                            SizedBox(
                              height: Get.height / 120,
                            ),
                           /* const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Categories",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                            ),
                            SizedBox(
                              height: Get.height / 60,
                            ),
                            TabBar(
                              controller: _tabController,
                              tabs: [
                                tabItemWidget1('assets/apple.png', "Apple"),
                                tabItemWidget1(
                                    'assets/samsung.png', "Samsung"),
                                tabItemWidget1('assets/realme.png', "Realme"),
                                *//*  tabItemWidget1(
                                    'assets/one_plus.png', "One Plus"),
                                tabItemWidget1('assets/mi.png', "Mi"),
                                tabItemWidget1('assets/apple.png', "Apple"),
                                tabItemWidget1('assets/apple.png', "Apple"),*//*
                              ],
                              indicatorColor: Colors.blue,
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.black87,
                              isScrollable: true,
                            ),

                            SizedBox(
                              height: Get.height / 120,
                            ),*/
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    !buttonController.searchButton.value
                                        ? 'Best Selling'.tr
                                        : 'Search Items'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                            ),
                            SizedBox(
                              height: Get.height / 120,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 0.0),
                                child: Center(
                                  child: !buttonController.searchButton.value
                                      ? fullList1(context)
                                      : customList(context),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customList(BuildContext context) {
    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());

    return buttonController.listIsEmpty.value
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
        : GetBuilder<GetxProductController>(builder: (controller) {
            return GetBuilder<GetxCartController>(builder: (controller) {
              return GetBuilder<GetxFavoriteController>(builder: (controller) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: searchItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Get.toNamed(GetxRoutes_Name.GetxProductDetailsScreen,
                              arguments: {
                                'Price': searchItems[index].price,
                                'Name': searchItems[index].title,
                                'ImageURL': searchItems[index].imageUrl,
                                'ShortDescription':
                                    searchItems[index].description,
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
                                          searchItems[index].imageUrl),
                                      width: Get.width / 2,
                                      height: Get.height / 5,
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
                                            child: searchItems[index]
                                                        .watchListItemId !=
                                                    ''
                                                ? InkWell(
                                                    onTap: () {
                                                      favoriteController
                                                          .getRemoveFavorite(
                                                              searchItems[index]
                                                                  .watchListItemId);
                                                      Future.delayed(
                                                          const Duration(
                                                              milliseconds: 0),
                                                          () async {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .hideCurrentSnackBar();

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Product Remove From Favorite!'
                                                                  .tr,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                            ),
                                                            backgroundColor:
                                                                Colors.indigo,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 1),
                                                          ),
                                                        );
                                                        await productController
                                                            .productAllAPI();
                                                        searchItemChange();
                                                        searchController
                                                            .clear();
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
                                                      await favoriteController
                                                          .getAddInFavorite(
                                                              searchItems[index]
                                                                  .id);

                                                      Future.delayed(
                                                          const Duration(
                                                              milliseconds: 0),
                                                          () async {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .hideCurrentSnackBar();

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Product Added To Favorite!'
                                                                  .tr,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                            ),
                                                            backgroundColor:
                                                                Colors.indigo,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 1),
                                                          ),
                                                        );
                                                        await productController
                                                            .productAllAPI();
                                                        searchItemChange();
                                                        searchController
                                                            .clear();
                                                      });
                                                    },
                                                    child: const Icon(
                                                      CupertinoIcons.heart,
                                                      size: 16,
                                                    ),
                                                  ),
                                          ),
                                          SizedBox(
                                            width: Get.width,
                                            child: AutoSizeText(
                                              searchItems[index].title,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 30),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height / 80,
                                          ),
                                          SizedBox(
                                            width: Get.width,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                '\$${searchItems[index].price}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height / 90,
                                          ),
                                          SizedBox(
                                            width: Get.width,
                                            child: AutoSizeText(
                                              searchItems[index].description,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 30),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height / 60,
                                          ),
                                          GetBuilder<GetxCartController>(
                                            builder: (controller) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                      child: searchItems[index]
                                                                  .quantity !=
                                                              0
                                                          ? InkWell(
                                                              onTap: () {},
                                                              child: Container(
                                                                width:
                                                                    Get.width,
                                                                height:
                                                                    Get.height /
                                                                        20,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .pink,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0)),
                                                                child: Center(
                                                                    child: Text(
                                                                  'Added in Cart'
                                                                      .tr,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap: () async {
                                                                await cartController
                                                                    .getAddToCart(
                                                                        searchItems[index]
                                                                            .id);

                                                                Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            0),
                                                                    () async {
                                                                  await productController
                                                                      .productAllAPI();
                                                                  await searchItemChange();
                                                                  searchController
                                                                      .clear();
                                                                });
                                                              },
                                                              onDoubleTap:
                                                                  () {},
                                                              onLongPress:
                                                                  () {},
                                                              child: Container(
                                                                width:
                                                                    Get.width,
                                                                height:
                                                                    Get.height /
                                                                        20,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .indigo,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0)),
                                                                child: Center(
                                                                    child: Text(
                                                                  'Add to Cart'
                                                                      .tr,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                              ),
                                                            )),
                                                ],
                                              );
                                            },
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
                    });
              });
            });
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

  GetBuilder<GetxController> fullList1(BuildContext context) {
    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());

    // return  GetBuilder<GetxProductController>(builder: (controller){
    return GetBuilder<GetxProductController>(builder: (controller) {
      return GetBuilder<GetxCartController>(builder: (controller) {
        return GetBuilder<GetxFavoriteController>(builder: (controller) {
          return !productController.isLoading.value
              ? productController.isLoadingItem
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productController.getProductAllAPI.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Get.toNamed(
                                GetxRoutes_Name.GetxProductDetailsScreen,
                                arguments: {
                                  'Price': productController
                                      .getProductAllAPI.data[index].price,
                                  'Name': productController
                                      .getProductAllAPI.data[index].title,
                                  'ImageURL': productController
                                      .getProductAllAPI.data[index].imageUrl,
                                  'ShortDescription': productController
                                      .getProductAllAPI.data[index].description,
                                  'Index': index,
                                });
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: productController
                                                .getProductAllAPI
                                                .data[index]
                                                .imageUrl
                                                .isNotEmpty
                                            ? Image(
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator(
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
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const SizedBox(
                                                    width: 100,
                                                    height: 100,
                                                    child: Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                                  );
                                                },
                                                image: NetworkImage(
                                                    productController
                                                        .getProductAllAPI
                                                        .data[index]
                                                        .imageUrl),
                                                width: Get.width / 2,
                                                height: Get.height / 5,
                                              )
                                            : const CircularProgressIndicator()),
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
                                              child: productController
                                                          .getProductAllAPI
                                                          .data[index]
                                                          .watchListItemId !=
                                                      ''
                                                  ? InkWell(
                                                      onTap: () {
                                                        favoriteController
                                                            .getRemoveFavorite(
                                                                productController
                                                                    .getProductAllAPI
                                                                    .data[index]
                                                                    .watchListItemId);
                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    0),
                                                            () async {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .hideCurrentSnackBar();

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Product Remove From Favorite!'
                                                                    .tr,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.indigo,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          1),
                                                            ),
                                                          );
                                                          await productController
                                                              .productAllAPI();
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
                                                        await favoriteController
                                                            .getAddInFavorite(
                                                                productController
                                                                    .getProductAllAPI
                                                                    .data[index]
                                                                    .id);

                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    0),
                                                            () async {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .hideCurrentSnackBar();

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Product Added To Favorite!'
                                                                    .tr,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.indigo,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          1),
                                                            ),
                                                          );
                                                          await productController
                                                              .productAllAPI();
                                                        });
                                                      },
                                                      child: const Icon(
                                                        CupertinoIcons.heart,
                                                        size: 16,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: Get.width,
                                              child: AutoSizeText(
                                                productController
                                                    .getProductAllAPI
                                                    .data[index]
                                                    .title,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 30),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height / 90,
                                            ),
                                            SizedBox(
                                              width: Get.width,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  '\$${productController.getProductAllAPI.data[index].price}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height / 60,
                                            ),
                                            SizedBox(
                                              width: Get.width,
                                              child: AutoSizeText(
                                                productController
                                                    .getProductAllAPI
                                                    .data[index]
                                                    .description,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 30),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height / 60,
                                            ),
                                            GetBuilder<GetxCartController>(
                                              builder: (controller) {
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                        child: productController
                                                                    .getProductAllAPI
                                                                    .data[index]
                                                                    .quantity !=
                                                                0
                                                            ? Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        width: Get
                                                                            .width,
                                                                        height:
                                                                            Get.height /
                                                                                20,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.pink,
                                                                            borderRadius: BorderRadius.circular(5.0)),
                                                                        child: Center(
                                                                            child: Text(
                                                                          'Added in Cart'
                                                                              .tr,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
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
                                                                            Get.rawSnackbar(
                                                                              messageText: const Text(
                                                                                'Item Quantity will be Decrease... Please Wait.....!!!!',
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              backgroundColor: Colors.indigo,
                                                                              snackPosition: SnackPosition.BOTTOM,
                                                                            );
                                                                            await cartController.decreaseProductQuantity(productController.getProductAllAPI.data[index].cartItemId);

                                                                            Future.delayed(const Duration(milliseconds: 0),
                                                                                () async {
                                                                              await productController.productAllAPI();
                                                                            });
                                                                          },
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.grey[200],
                                                                            // Colors.pink[500],
                                                                            radius:
                                                                                14,
                                                                            child: const Center(
                                                                                child: Icon(
                                                                              Icons.remove,
                                                                              color: Colors.black,
                                                                            )),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          productController
                                                                              .getProductAllAPI
                                                                              .data[index]
                                                                              .quantity
                                                                              .toString(),
                                                                          style:
                                                                              const TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            await cartController.increaseProductQuantity(productController.getProductAllAPI.data[index].cartItemId);
                                                                            Get.rawSnackbar(
                                                                              messageText: const Text(
                                                                                'Item Quantity will be Increase... Please Wait.....!!!!',
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              backgroundColor: Colors.indigo,
                                                                              snackPosition: SnackPosition.BOTTOM,
                                                                            );
                                                                            productController.productAllAPI();
                                                                          },
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.grey[200],
                                                                            radius:
                                                                                14,
                                                                            child: const Center(
                                                                                child: Icon(
                                                                              Icons.add,
                                                                              color: Colors.black,
                                                                            )),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : InkWell(
                                                                onTap:
                                                                    () async {
                                                                  productController
                                                                          .isLoadingItem =
                                                                      false;
                                                                  Get.rawSnackbar(
                                                                    messageText:
                                                                        const Text(
                                                                      'Item will be Added in Cart... Please Wait.....!!!!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .indigo,
                                                                    snackPosition:
                                                                        SnackPosition
                                                                            .BOTTOM,
                                                                  );
                                                                  await cartController.getAddToCart(
                                                                      productController
                                                                          .getProductAllAPI
                                                                          .data[
                                                                              index]
                                                                          .id);
                                                                  productController
                                                                      .productAllAPI();
                                                                },
                                                                onDoubleTap:
                                                                    () {},
                                                                onLongPress:
                                                                    () {},
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      Get.width,
                                                                  height:
                                                                      Get.height /
                                                                          20,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .indigo,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0)),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    'Add to Cart'
                                                                        .tr,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                                ),
                                                              )),
                                                  ],
                                                );
                                              },
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
                  : const CircularProgressIndicator()
              : const CircularProgressIndicator();
        });
      });
    });
  }

  updateLocale(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: const Text('Choose language'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        updateLocale(locale1[index]['locale']);
                        saveLocale(locale1[index]['locale']);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          locale1[index]['name'],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: locale1.length),
            ),
          );
        });
  }
}
