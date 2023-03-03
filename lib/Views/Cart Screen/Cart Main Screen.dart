import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/Drawer.dart';

class CartMainScreen extends StatefulWidget {
  const CartMainScreen({Key? key}) : super(key: key);

  @override
  State<CartMainScreen> createState() => _CartMainScreenState();
}

class _CartMainScreenState extends State<CartMainScreen> {
  int counter = 1;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    if (counter > 1) {
      setState(() {
        counter--;
      });
    }
  }

  bool SearchButton = false;
  bool ListIsEmpty = false;
  TextEditingController search = TextEditingController();
  Icon CustomSearch = const Icon(
    Icons.search,
    color: Colors.indigo,
  );
  Widget CustomText = const Text(
    "Search",
    style: TextStyle(color: Colors.indigo),
  );
  List<dynamic> SearchItems = [];
  List<dynamic> FavoriteItems = [];
  @override
  void initState() {
    // TODO: implement initState
    SearchItems = MainData;
    super.initState();
  }

  List<dynamic> MainData = [
    ProductList(
      Name: 'iPhone 11 pro',
      Price: 120000,
      ShortDescription:
          'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "assets/realme.png",
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(context, Colors.indigo),

      /*   appBar: AppBar(

          leading: SearchButton
              ? IconButton(
              onPressed: () {
                setState(() {
                  SearchButton = false;
                  CustomSearch = const Icon(Icons.search,color: Colors.indigo,);
                  CustomText = const Text("Search");
                });
              },
              icon: const Icon(Icons.arrow_back_outlined,color: Colors.indigo,))
              : Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.indigo, // Change Custom Drawer Icon Color
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title:SearchButton
              ? CustomText : const Text(
            "Cart Screen",
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
                      CustomSearch = const Icon(Icons.clear,color: Colors.indigo,);
                      CustomText = TextField(
                        textInputAction: TextInputAction.go,
                        controller: search,
                        onChanged: (value) => onSearchTextChanged(value),
                        //onChanged: (Value) => updateList(Value),
                        decoration: const InputDecoration(
                            hintText: "Search....",
                            hintStyle: TextStyle(color: Colors.indigo),
                            //
                            border: UnderlineInputBorder()
                        ),
                        style: const TextStyle(color: Colors.indigo, fontSize: 20),
                      );
                    } else {
                      // CustomSearch = const Icon(Icons.search);
                      search.clear();
                      onSearchTextChanged("");
                    }
                  });
                }),
            //!SearchButton ? IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,color: Colors.indigo,)) : const SizedBox(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.option,
                  color: Colors.indigo,
                )),

          ]),*/
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: InkWell(
              onTap: () {},
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
          padding: EdgeInsets.only(top: 12.0),
          child: Center(
              child: Text(
            "My Cart",
            style: TextStyle(color: Colors.black),
          )),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      // backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 50,
            ),
            Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(246, 244, 244, 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0),
                      topLeft: Radius.circular(16.0))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child:
                      !SearchButton ? FullList1(context) : customlist1(context),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: (){},
              child: Container(
                height: size.height/20,
                color: Colors.orange,
                child: const Center(child: Text("Total Price-100000",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: (){},
              child: Container(
                height: size.height/20,

                color: Colors.indigo,
                child: const Center(child: Text("Place Order",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customlist1(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              bool isSaved = FavoriteItems.contains(SearchItems[index]);

              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage(SearchItems[index].ImageURL),
                                // image: AssetImage('first.jpg'),
                                /* width: size.width / 2,
                                  height: size.height / 4,*/
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width / 50,
                                  ),
                                  IconButton(
                                    onPressed: decrement,
                                    icon: const Icon(Icons.remove),
                                    tooltip: "Item Remove",
                                  ),
                                  Text(
                                    '$counter',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: increment,
                                    icon: const Icon(Icons.add),
                                    tooltip: "Item added",
                                  ),
                                  SizedBox(
                                    width: size.width / 50,
                                  ),
                                ],
                              )
                            ],
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
                                              FavoriteItems.remove(
                                                  MainData[index]);
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
                                              FavoriteItems.add(
                                                  MainData[index]);
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
                                      '₹${counter * SearchItems[index].Price}',
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
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                CupertinoIcons.delete))),
                                    SizedBox(
                                      width: size.width / 70,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        width: size.width,
                                        height: size.height / 20,
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: const Center(
                                            child: Text(
                                          "Place Order",
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

  Widget FullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            itemCount: MainData.length,
            itemBuilder: (context, index) {
              bool isSaved = FavoriteItems.contains(MainData[index]);

              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Image(
                                  image: AssetImage(MainData[index].ImageURL),
                                  // image: AssetImage('first.jpg'),
                                  width: size.width / 4,
                                    height: size.height / 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Align(
                                      alignment: Alignment.topRight,
                                      child: isSaved
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  FavoriteItems.remove(
                                                      MainData[index]);
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
                                                  FavoriteItems.add(
                                                      MainData[index]);
                                                  print(FavoriteItems.toString());
                                                });
                                              },
                                              child: const Icon(
                                                CupertinoIcons.heart,
                                                size: 16,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: AutoSizeText(
                                    MainData[index].Name,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 30),
                                  ),
                                ),  SizedBox(
                                  height: size.height / 70,
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: AutoSizeText(
                                    MainData[index].ShortDescription,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 30),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 70,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: size.width,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: AutoSizeText(
                                              '₹${counter * MainData[index].Price}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              CupertinoIcons.delete)),
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [

                                          InkWell(
                                            onTap: decrement,
                                            child:  CircleAvatar(
                                              backgroundColor: Colors.grey[200],
                                              radius: 14,
                                              child: const Center(child: Icon(Icons.remove,color: Colors.black,)),
                                            ),
                                          ),
                                          Text(
                                            '$counter',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),

                                          InkWell(
                                            onTap: increment,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey[200],
                                              radius: 14,
                                              child: const Center(child: Icon(Icons.add,color: Colors.black,)),
                                            ),
                                          )

                                        ],
                                      ),
                                    )
                                  ],
                                ),

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
