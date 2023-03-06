import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Favorite_add_provider.dart';
import '../../Utils/Drawer.dart';

class FavoriteMainScreen extends StatefulWidget {
  const FavoriteMainScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteMainScreen> createState() => _FavoriteMainScreenState();
}

class _FavoriteMainScreenState extends State<FavoriteMainScreen> {
  bool SearchButton = false;
  bool ListIsEmpty = false;
  TextEditingController search = TextEditingController();
  Icon CustomSearch =  const Icon(Icons.search,color: Colors.indigo,);
  Widget CustomText =  const Text("Search",style: TextStyle(color: Colors.indigo),);
  List<dynamic> SearchItems = [];
  List<dynamic> FavoriteItems = [];




  @override
  void initState() {
    // TODO: implement initState
    SearchItems = MainData;
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


  List<dynamic> MainData = [
    ProductList(
      Name: 'iPhone 11 pro',
      Price: 120000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/first.jpg",
    ),
    ProductList(
      Name: 'iPhone 12 pro',
      Price: 140000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/first.jpg",
    ),
    ProductList(
      Name: 'iPhone 13 pro',
      Price: 160000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/first.jpg",
    ),
    ProductList(
      Name: 'iPhone 14 pro',
      Price: 180000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/first.jpg",
    ),
    ProductList(
      Name: 'iPhone 15 pro',
      Price: 200000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/first.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final FavoriteProvider = Provider.of<Favorite_add_provider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(context,Colors.indigo),
      appBar: AppBar(
          leading: SearchButton
              ? IconButton(
              onPressed: () {
                setState(() {
                  SearchButton = false;
                  CustomSearch =  const Icon(Icons.search,color: Colors.indigo,);
                  CustomText = const Text("Search");
                });
              },
              icon:  const Icon(Icons.arrow_back_outlined,color: Colors.indigo,))
              : Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon:  const Icon(
                  Icons.menu,
                  color: Colors.indigo // Change Custom Drawer Icon Color
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title:SearchButton
              ? CustomText :  const Text(
            "Favourite Screen",
            style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [

            IconButton(
                icon: CustomSearch,
                onPressed: () {
                  setState(() {
                    if (CustomSearch.icon == Icons.search) {
                      SearchButton = true;
                      CustomSearch =  const Icon(Icons.clear,color: Colors.indigo);
                      CustomText = TextField(
                        textInputAction: TextInputAction.go,
                        controller: search,
                        onChanged: (value) => onSearchTextChanged(value),
                        //onChanged: (Value) => updateList(Value),
                        decoration:  const InputDecoration(
                            hintText: "Search....",
                            hintStyle: TextStyle(color: Colors.indigo),
                            //
                            border: UnderlineInputBorder()
                        ),
                        style:  const TextStyle(color: Colors.indigo, fontSize: 20),
                      );
                    } else {
                      // CustomSearch = const Icon(Icons.search);
                      search.clear();
                      onSearchTextChanged("");
                    }
                  });
                }),
            //!SearchButton ? IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,color: Colors.lightGreen[900],)) : const SizedBox(),
            IconButton(
                onPressed: () {},
                icon:  const Icon(
                  CupertinoIcons.option,
                  color: Colors.indigo,
                )),

          ]),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: !SearchButton ? FullList1(context) : customlist1(context),
          ),
        ),
      ),
    );
  }
  Widget customlist1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
 //   final FavoriteProvider = Provider.of<Favorite_add_provider>(context);

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
        itemCount: FavoriteItems.length,
        itemBuilder: (context, index) {
          bool isSaved = FavoriteItems.contains(SearchItems[index]);

          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage(SearchItems[index].ImageURL),
                        /* width: size.width / 2,
                              height: size.height / 4,*/
                      ),
                    ),
                    Expanded(
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
                                    FavoriteItems.remove(MainData[index]);
                                    print(FavoriteItems.toString());
                                  });
                                },
                                child: const Icon(
                                  CupertinoIcons.heart_solid,
                                  size: 16,
                                ),
                              )
                                  : InkWell(
                                onTap: () {
                                  setState(() {
                                    FavoriteItems.add(MainData[index]);
                                    print(FavoriteItems.toString());
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

  ListView FullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FavoriteProvider = Provider.of<Favorite_add_provider>(context);

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: FavoriteProvider.FavoriteList.length,
        itemBuilder: (context, index) {
          bool isSaved = FavoriteProvider.FavoriteList.contains(index);
          List<dynamic> FavoriteItem = FavoriteProvider.FavoriteList;

          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage(FavoriteItem[index].ImageURL),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child:
                              isSaved ? InkWell(
                                onTap: () {
                                  setState(() {
                                    /*  FavoriteItems.remove(MainData[index]);
                                          print(FavoriteItems.toString());*/
                                  /*  FavoriteProvider.RemoveFavoriteItems(index);*/
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
                                child:  const Icon(
                                  CupertinoIcons.heart_solid,
                                  color: Colors.red,
                                  size: 16,
                                ),
                              )
                                  : InkWell(
                                onTap: () {
                                  setState(() {
                                    print(FavoriteProvider.FavoriteList.toList().contains(MainData[index].Name));
                                    /* FavoriteItems.add(MainData[index]);
                                          print(FavoriteItems.toString());*/
                                    /*FavoriteProvider.AddFavoriteItems(index);
*/
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
                                FavoriteItem[index].Name,
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
                                    fontWeight: FontWeight.w300, fontSize: 30),
                              ),
                            ),
                            SizedBox(
                              height: size.height / 50,
                            ),
                            Row(
                              children: [
                                Expanded(
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

