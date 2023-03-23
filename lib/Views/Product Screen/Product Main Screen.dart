import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Controller/Favorite_add_provider.dart';
import 'package:online_ordering_system/Controller/Cart_items_provider.dart';
import 'package:online_ordering_system/Utils/Routes_Name.dart';
import 'package:provider/provider.dart';
import '../../Controller/ChangeControllerClass.dart';
import '../../Models/FavoriteListModelClass.dart';
import '../../Models/ProductListModelClass.dart';
import '../../Utils/Drawer.dart';

class ProductMainScreen extends StatefulWidget {
  const ProductMainScreen({Key? key}) : super(key: key);

  @override
  State<ProductMainScreen> createState() => _ProductMainScreenState();
}

class _ProductMainScreenState extends State<ProductMainScreen>
    with TickerProviderStateMixin {


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> searchItems = [];
 // TabController? _tabController;
  //int photoIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    searchItems = mainData;
   // _tabController = TabController(vsync: this, length: 11);
    accessApi();
    super.initState();
  }



  final List<String> imgList = [
    'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
    'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
    'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
  ];

  Future<void> accessApi() async {
    /*ApiConncection.getData().then((value) {

    });*/
  }

  List<dynamic> mainData = [
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
    final cartProvider = Provider.of<Purchase_items_provider>(context);
    final changeControllerClass = Provider.of<ChangeControllerClass>(context);
    Size size = MediaQuery.of(context).size;
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
                                            cartProvider.PurchaseList.length
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
                              child: Consumer<ChangeControllerClass>(builder: (context,value,child){
                                return CupertinoSearchTextField(
                                  backgroundColor: Colors.white,
                                  itemSize: size.height / 33,
                                  controller: changeControllerClass.controller,
                                  onChanged: (value) {
                                    changeControllerClass.searchButtonPress();

                                    if(value.isEmpty){
                                      changeControllerClass.searchButtonUnPress();
                                    }

                                    List<dynamic> result = [];
                                    if (value.isEmpty) {
                                      result = mainData;
                                    } else {
                                      result = mainData.where((element) => element.Name.toString()
                                          .toLowerCase()
                                          .contains(value.toLowerCase())).toList();
                                    }

                                    if (result.isEmpty) {
                                      changeControllerClass.listIsEmpty();
                                    } else {
                                      changeControllerClass.listNotEmpty();
                                    }
                                    changeControllerClass.searchItems = result;
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
                            onPageChanged: (index,reason){
                              changeControllerClass.photoIndex(index);
                            }
                          ),
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
                              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: changeControllerClass.photoIndex1 == index ? const Color.fromRGBO(0, 0,0,0.9) : const Color.fromRGBO(0, 0, 0, 0.4),

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
                          height: size.height / 100,
                        ),
                         Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                               !changeControllerClass.searchButton ? "Best Selling":"Search List",
                                style:const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )),
                        ),
                        SizedBox(
                          height: size.height / 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Center(
                            child: !changeControllerClass.searchButton
                                ? fullList1(context)
                                : customList1(context),
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

  Widget customList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final favoriteProvider = Provider.of<Favorite_add_provider>(context);
    final cartProvider = Provider.of<Purchase_items_provider>(context);
    final changeControllerClass =  Provider.of<ChangeControllerClass>(context);

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
              bool isSaved = favoriteProvider.FavoriteList.any(
                  (element) => element.Name.contains(changeControllerClass.searchItems[index].Name));
              bool isAddedInCart1 = cartProvider.PurchaseList.any((element1) =>
                  element1.Name.contains(changeControllerClass.searchItems[index].Name));

              return InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushNamed(context, Routes_Name.ProductDetailsScreen,
                      arguments: {
                        'Price': changeControllerClass.searchItems[index].Price,
                        'Name': changeControllerClass.searchItems[index].Name,
                        'ImageURL': changeControllerClass.searchItems[index].ImageURL,
                        'ShortDescription' : changeControllerClass.searchItems[index].ShortDescription,
                        'Index' : index,
                      });
                },
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Image(
                              image: AssetImage(changeControllerClass.searchItems[index].ImageURL),
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

                                                favoriteProvider
                                                    .RemoveFavoriteItems(
                                                        favoriteProvider
                                                            .FavoriteList[index]);


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

                                                favoriteProvider.AddFavoriteItems(
                                                    FavoriteListModelClass(
                                                        Price: changeControllerClass.searchItems[index]
                                                            .Price,
                                                        Name: changeControllerClass.searchItems[index]
                                                            .Name,
                                                        ShortDescription:
                                                            changeControllerClass.searchItems[index]
                                                                .ShortDescription,
                                                        ImageURL:
                                                            changeControllerClass.searchItems[index]
                                                                .ImageURL,
                                                        Count: 1));



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
                                      changeControllerClass.searchItems[index].Name,
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
                                        '₹${changeControllerClass.searchItems[index].Price}',
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
                                      changeControllerClass.searchItems[index].ShortDescription,
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
                                                  cartProvider.addItemToCart(
                                                      FavoriteListModelClass(
                                                          Price:
                                                              changeControllerClass.searchItems[index]
                                                                  .Price,
                                                          Name: changeControllerClass.searchItems[index]
                                                              .Name,
                                                          ShortDescription:
                                                              changeControllerClass.searchItems[index]
                                                                  .ShortDescription,
                                                          ImageURL:
                                                              changeControllerClass.searchItems[index]
                                                                  .ImageURL,
                                                          Count: 1));
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
    Size size = MediaQuery.of(context).size;
    final favoriteProvider = Provider.of<Favorite_add_provider>(context);
    final cartProvider = Provider.of<Purchase_items_provider>(context);

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: mainData.length,
        itemBuilder: (context, index) {
          // bool isSaved = FavoriteProvider.FavoriteList1.contains(FavoriteProvider.FavoriteList1);
          // bool isSaved = FavoriteProvider.FavoriteList.contains(MainData[index]);

          bool isSaved = favoriteProvider.FavoriteList.any(
              (element) => element.Name.contains(mainData[index].Name));
          bool isAddedInCart = cartProvider.PurchaseList.any(
              (element1) => element1.Name.contains(mainData[index].Name));

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
                    'ShortDescription' : mainData[index].ShortDescription,
                    'Index' : index,
                  });
            },
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image(
                          image: AssetImage(mainData[index].ImageURL),
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

                                            favoriteProvider
                                                .RemoveFavoriteItems(
                                                    favoriteProvider
                                                        .FavoriteList[index]);


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

                                            favoriteProvider.AddFavoriteItems(
                                                FavoriteListModelClass(
                                                    Price:
                                                        mainData[index].Price,
                                                    Name: mainData[index].Name,
                                                    ShortDescription:
                                                        mainData[index]
                                                            .ShortDescription,
                                                    ImageURL: mainData[index]
                                                        .ImageURL,
                                                    Count: 1));



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
                                  mainData[index].Name,
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
                                    '₹${mainData[index].Price}',
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
                                  mainData[index].ShortDescription,
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
                                            onTap: () {
                                           /*   cartProvider.PurchaseList[index]
                                                  .Count++;
                                              print(cartProvider
                                                  .PurchaseList[index].Count);*/
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
                                                style:  TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              cartProvider.addItemToCart(
                                                  FavoriteListModelClass(
                                                      Price:
                                                          mainData[index].Price,
                                                      Name:
                                                          mainData[index].Name,
                                                      ShortDescription:
                                                          mainData[index]
                                                              .ShortDescription,
                                                      ImageURL: mainData[index]
                                                          .ImageURL,
                                                      Count: 1));
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
}
