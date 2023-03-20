import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Controller/GetxFavoriteController.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';

import '../../../Utils/Drawer.dart';
import '../../Getx_Controller/GetxCartController.dart';
import '../../Getx_Controller/GetxProductController.dart';

class GetProductMainScreen extends StatefulWidget {
  const GetProductMainScreen({Key? key}) : super(key: key);

  @override
  State<GetProductMainScreen> createState() => _GetProductMainScreenState();
}

class _GetProductMainScreenState extends State<GetProductMainScreen> {

  final productController = Get.put(GetxProductController());
  bool searchButton = false;
  bool listIsEmpty = false;
  TextEditingController search = TextEditingController();
  Icon customSearch = const Icon(
    Icons.search,
    color: Colors.indigo,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();
  Widget customText = const Text(
    "Search",
    style: TextStyle(color: Colors.indigo),
  );
  List<dynamic> searchItems = [];
  List<dynamic> favoriteItems = [];
  int photoIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    searchItems = productController.productData;
    super.initState();
  }

  void onSearchTextChanged(String text) {
    List<dynamic>? result = [];
    if (text.isEmpty) {
      result = productController.productData;
    } else {
      result = productController.productData.where((element) =>
          element.Name.toString()
              .toLowerCase()
              .contains(text.toLowerCase())).toList();
    }

    setState(() {
      if (result!.isEmpty) {
        listIsEmpty = true;
      } else {
        listIsEmpty = false;
      }
      searchItems = result;
    });
  }

  final List<String> imgList = [
    'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
    'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
    'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: drawerWidget(context, Colors.indigo),
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
                                    context,
                                    GetxRoutes_Name.GetxCartMainScreen);
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
                                          child: const Text(
                                            "1",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
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
                          height: Get.height / 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CupertinoSearchTextField(
                                backgroundColor: Colors.white,
                                itemSize: Get.height / 33,
                                controller: controller,
                                onChanged: (value) {
                                  setState(() {
                                    searchButton = true;
                                  });
                                  onSearchTextChanged(value);
                                },
                                onSuffixTap: () {
                                  setState(() {
                                    searchButton = false;
                                    controller.clear();
                                  });
                                },
                                onSubmitted: (value) {},
                                autocorrect: true,
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 60,
                            ),
                            Container(
                              height: Get.height / 25,
                              width: Get.width / 16,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black),
                              child: const Icon(
                                CupertinoIcons.line_horizontal_3_decrease,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height / 50,
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                              height: 200,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  photoIndex = index;
                                });
                              }
                          ),
                          items: imgList
                              .map((item) =>
                              Center(
                                  child: Image.network(item,
                                      fit: BoxFit.cover,
                                      width: Get.width / 1.1)))
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
                                  color: photoIndex == index ? const Color
                                      .fromRGBO(0, 0, 0, 0.9) : const Color
                                      .fromRGBO(0, 0, 0, 0.4),

                                ),
                              );
                            }).toList()
                        ),
                        /*  SizedBox(
                          height: size.height / 60,
                        ),*/
                        /*   const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Categories",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )),
                        ),
                        SizedBox(
                          height: size.height / 60,
                        ),
                      TabBar(
                          controller: _tabController,
                          tabs: [
                            TabItemWidget1('assets/apple.png', "Apple"),
                            TabItemWidget1('assets/samsung.png', "Samsung"),
                            TabItemWidget1('assets/realme.png', "Realme"),
                            TabItemWidget1('assets/one_plus.png', "One Plus"),
                            TabItemWidget1('assets/mi.png', "Mi"),
                            TabItemWidget1('assets/apple.png', "Apple"),
                            TabItemWidget1('assets/samsung.png', "Samsung"),
                            TabItemWidget1('assets/realme.png', "Realme"),
                            TabItemWidget1('assets/one_plus.png', "One Plus"),
                            TabItemWidget1('assets/mi.png', "Mi"),
                            TabItemWidget1('assets/apple.png', "Apple"),
                          ],
                          indicatorColor: Colors.blue,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black87,
                          isScrollable: true,
                        ),*/
                        SizedBox(
                          height: Get.height / 100,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Best Selling",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )),
                        ),
                        SizedBox(
                          height: Get.height / 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Center(
                            child: !searchButton
                                ? fullList1(context)
                                : customlist1(context),
                          ),
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
  Widget customlist1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());


    return listIsEmpty
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
        :
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: searchItems.length,
        itemBuilder: (context, index) {
          bool isAdded = cartController.cartData.any((element) =>
              element.Name.contains(productController.productData[index].Name));
          bool isSaved = favoriteController.favoriteData.any((element) =>
              element.Name.contains(
                  favoriteController.favoriteData[index].Name));


          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {

            },
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image(
                          image: AssetImage(searchItems[index].ImageURL),
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
                                  searchItems[index].Name,
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
                                    '₹${searchItems[index].Price}',
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
                                  searchItems[index].ShortDescription,
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
                                    child: isAdded
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

  ListView fullList1(BuildContext context) {
    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());



   // return  GetBuilder<GetxProductController>(builder: (controller){
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: productController.productData.length,
        itemBuilder: (context, index) {
          bool isAdded = cartController.cartData.any((element) =>
              element.Name.contains(productController.productData[index].Name));
          bool isSaved = favoriteController.favoriteData.any((element) =>
              element.Name.contains(
                  productController.productData[index].Name));

          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {

            },
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image(
                          image: AssetImage(productController.productData[index]
                              .ImageURL),
                          width: Get.width / 2,
                          height: Get.height / 4,
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
                                    favoriteController.removeToFavorite(productController.productData[index]);

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
                                    size: 16,
                                  ),
                                )
                                    : InkWell(
                                  onTap: () {
                                    favoriteController.addToFavorite(productController.productData[index]);


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
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width,
                                child: AutoSizeText(
                                  productController.productData[index].Name,
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
                                    '₹${productController.productData[index]
                                        .Price}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height / 80,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: AutoSizeText(
                                  productController.productData[index]
                                      .ShortDescription,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 30),
                                ),
                              ),
                              SizedBox(
                                height: Get.height / 50,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: isAdded
                                        ? InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: Get.width,
                                        height: Get.height / 20,
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
                                        :  InkWell(
                                      onTap: () {
                                        cartController.addToCart(productController.productData[index]);
                                        },
                                      child: Container(
                                        width: Get.width,
                                        height: Get.height / 20,
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
  }
