import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/Drawer.dart';

class OrderPlaceMainScreen extends StatefulWidget {
  const OrderPlaceMainScreen({Key? key}) : super(key: key);

  @override
  State<OrderPlaceMainScreen> createState() => _OrderPlaceMainScreenState();
}

class _OrderPlaceMainScreenState extends State<OrderPlaceMainScreen> {

  bool SearchButton = false;
  bool ListIsEmpty = false;
  TextEditingController search = TextEditingController();
  Icon CustomSearch =  const Icon(Icons.search,color: Colors.indigo,);
  Widget CustomText =  const Text("Search",style: TextStyle(color: Colors.indigo),);
  List<dynamic> SearchItems = [];

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
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powepink by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powepink by a 3046mAh non-removable battery. ',
      ImageURL: "assets/first.jpg", LastOrder: '22-02-2023',
    ),
    ProductList(
      Name: 'iPhone 12 pro',
      Price: 140000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powepink by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powepink by a 3046mAh non-removable battery. ',
      ImageURL: "assets/first.jpg", LastOrder: '24-02-2023',
    ),

  ];
  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(context,Colors.indigo!),
      appBar: AppBar(
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
                icon:  const Icon(
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
            "Order Place Screen",
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
                        style: const  TextStyle(color: Colors.indigo, fontSize: 20),
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
          ]),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: !SearchButton ? FullList1(context) : customlist1(context),
        ),
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
        itemCount: SearchItems.length,
        itemBuilder: (context, index) {
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
                              child: AutoSizeText(
                                  "Order Place Date:- ${SearchItems[index].LastOrder}",
                              maxLines: 1,)),

                            SizedBox(
                              height: size.height / 70,
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
                              height: size.height / 70,
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
                                          "Again Add to Cart",
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

    return ListView.builder(
        itemCount: MainData.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage(MainData[index].ImageURL),
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
                                child: AutoSizeText(
                                  "Order Place Date:- ${SearchItems[index].LastOrder}",
                                  maxLines: 1,)),

                            SizedBox(
                              height: size.height / 70,
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
                              height: size.height / 70,
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
                              height: size.height / 70,
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
                              height: size.height / 70,
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
                                          "Again Add to Cart",
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
  String LastOrder;

  ProductList(
      {required this.Price,
        required this.Name,
        required this.ShortDescription,
        required this.ImageURL,
      required this.LastOrder});
}

