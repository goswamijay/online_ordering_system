import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Controller/Favorite_add_provider.dart';
import 'package:online_ordering_system/Controller/Cart_items_provider.dart';
import 'package:online_ordering_system/HomePage.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';
import 'package:provider/provider.dart';

import '../../Models/FavoriteListModelClass.dart';
import '../../Utils/Drawer.dart';

class ProductMainScreen extends StatefulWidget {
  const ProductMainScreen({Key? key}) : super(key: key);

  @override
  State<ProductMainScreen> createState() => _ProductMainScreenState();
}

class _ProductMainScreenState extends State<ProductMainScreen>
    with TickerProviderStateMixin {
  bool SearchButton = false;
  bool ListIsEmpty = false;
  bool isSaved = false;
  TextEditingController search = TextEditingController();
  Icon CustomSearch = const Icon(
    Icons.search,
    color: Colors.indigo,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();
  Widget CustomText = const Text(
    "Search",
    style: TextStyle(color: Colors.indigo),
  );
  List<dynamic> SearchItems = [];
  List<dynamic> FavoriteItems = [];
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    SearchItems = MainData;
    _tabController = TabController(vsync: this, length: 11);
    super.initState();
  }

  void onSearchTextChanged(String text) {
    List<dynamic>? Result = [];
    if (text.isEmpty) {
      Result = MainData;
    } else {
      Result = MainData.where((element) => element.Name.toString()
          .toLowerCase()
          .contains(text.toLowerCase())).toList();
    }

    setState(() {
      if (Result!.isEmpty) {
        ListIsEmpty = true;
      } else {
        ListIsEmpty = false;
      }
      SearchItems = Result!;
    });
  }

  final List<String> imgList = [
    'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
    'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
    'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
  ];

  List<dynamic> MainData = [
    ProductList(
      Name: 'iPhone 11 Pro Max',
      Price: 120000,
      ShortDescription:
          'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/ItemsPhoto/iphone_11.png",
    ),
    ProductList(
      Name: 'iPhone 12 Pro Max',
      Price: 140000,
      ShortDescription:
          'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/ItemsPhoto/iphone_12.png",
    ),
    ProductList(
      Name: 'iPhone 13 Pro Max',
      Price: 160000,
      ShortDescription:
          'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/ItemsPhoto/iphone_13.png",
    ),
    ProductList(
      Name: 'iPhone 14 Pro Max',
      Price: 180000,
      ShortDescription:
          'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/ItemsPhoto/iphone_14.png",
    ),
    ProductList(
      Name: 'iPhone 15 pro',
      Price: 200000,
      ShortDescription:
          'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/ItemsPhoto/iphone_12.png",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final CartProvider = Provider.of<Purchase_items_provider>(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(context, Colors.indigo),
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
                        SizedBox(
                          height: size.height / 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CupertinoSearchTextField(
                                backgroundColor: Colors.white,
                                itemSize: size.height / 33,
                                controller: controller,
                                onChanged: (value) {
                                  setState(() {
                                    SearchButton = true;
                                  });
                                  onSearchTextChanged(value);
                                },
                                onSuffixTap: () {
                                  setState(() {
                                    SearchButton = false;
                                    controller.clear();
                                  });
                                },
                                onSubmitted: (value) {},
                                autocorrect: true,
                              ),
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
                              child: const Icon(
                                CupertinoIcons.line_horizontal_3_decrease,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
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
                          ),
                          items: imgList
                              .map((item) => Center(
                                  child: Image.network(item,
                                      fit: BoxFit.cover,
                                      width: size.width / 1.1)))
                              .toList(),
                        ),
                        SizedBox(
                          height: size.height / 60,
                        ),
                        const Padding(
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
                        ),
                        SizedBox(
                          height: size.height / 80,
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
                          height: size.height / 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Center(
                            child: !SearchButton
                                ? FullList1(context)
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
    final FavoriteProvider = Provider.of<Favorite_add_provider>(context);
    final CartProvider = Provider.of<Purchase_items_provider>(context);

    return ListIsEmpty
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
            itemCount: SearchItems.length,
            itemBuilder: (context, index) {
              bool isSaved = FavoriteProvider.FavoriteList.any(
                  (element) => element.Name.contains(MainData[index].Name));
              bool isAddedInCart1 = CartProvider.PurchaseList.any(
                      (element1) => element1.Name.contains(SearchItems[index].Name));

              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Image(
                            image: AssetImage(SearchItems[index].ImageURL),
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
                                              FavoriteProvider.AddFavoriteItems(
                                                  FavoriteListModelClass(
                                                      Price:
                                                      SearchItems[index].Price,
                                                      Name:
                                                      SearchItems[index].Name,
                                                      ShortDescription:
                                                      SearchItems[index]
                                                              .ShortDescription,
                                                      ImageURL: SearchItems[index]
                                                          .ImageURL,Count: 1));
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
                                    SearchItems[index].Name,
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
                                      '₹${SearchItems[index].Price}',
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
                                    SearchItems[index].ShortDescription,
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
                                          CartProvider.AddItemToCart(
                                              FavoriteListModelClass(
                                                  Price:
                                                  SearchItems[index].Price,
                                                  Name: SearchItems[index].Name,
                                                  ShortDescription:
                                                  SearchItems[index]
                                                      .ShortDescription,
                                                  ImageURL: SearchItems[index]
                                                      .ImageURL,Count: 1));
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

  Widget TabItemWidget1(String logo, String name) {
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

  ListView FullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FavoriteProvider = Provider.of<Favorite_add_provider>(context);
    final CartProvider = Provider.of<Purchase_items_provider>(context);

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: MainData.length,
        itemBuilder: (context, index) {
          // bool isSaved = FavoriteProvider.FavoriteList1.contains(FavoriteProvider.FavoriteList1);
          // bool isSaved =
          //   FavoriteProvider.FavoriteList.contains(MainData[index]);

          bool isSaved = FavoriteProvider.FavoriteList.any(
              (element) => element.Name.contains(MainData[index].Name));
          bool isAddedInCart = CartProvider.PurchaseList.any(
              (element1) => element1.Name.contains(MainData[index].Name));

          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage(MainData[index].ImageURL),
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
                                          FavoriteProvider.RemoveFavoriteItems(
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
                                        setState(() {
                                          FavoriteProvider.AddFavoriteItems(
                                              FavoriteListModelClass(
                                                  Price: MainData[index].Price,
                                                  Name: MainData[index].Name,
                                                  ShortDescription:
                                                      MainData[index]
                                                          .ShortDescription,
                                                  ImageURL: MainData[index]
                                                      .ImageURL,Count: 1));
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
                                        size: 16,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              width: size.width,
                              child: AutoSizeText(
                                MainData[index].Name,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 30),
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
                                  '₹${MainData[index].Price}',
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
                                MainData[index].ShortDescription,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 30),
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
                                            CartProvider.AddItemToCart(
                                                FavoriteListModelClass(
                                                    Price:
                                                        MainData[index].Price,
                                                    Name: MainData[index].Name,
                                                    ShortDescription:
                                                        MainData[index]
                                                            .ShortDescription,
                                                    ImageURL: MainData[index]
                                                        .ImageURL,
                                                Count: 1));
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

class ProductList {
  int Price;
  String Name;
  String ShortDescription;
  String ImageURL;

  ProductList(
      {required this.Price,
      required this.Name,
      required this.ShortDescription,
      required this.ImageURL});
}
