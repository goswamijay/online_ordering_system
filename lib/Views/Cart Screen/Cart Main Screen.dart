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


  void increment(){
    setState(() {
      counter++;
    });
  }

  void decrement(){
    if(counter > 0) {
      setState(() {
        counter--;
      });
    }
  }

  bool SearchButton = false;
  bool ListIsEmpty = false;
  TextEditingController search = TextEditingController();
  Icon CustomSearch = const Icon(Icons.search,color: Colors.deepOrange,);
  Widget CustomText = const Text("Search",style: TextStyle(color: Colors.deepOrange),);
  List<dynamic> SearchItems = [];

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
      ImageURL: "first.jpg",
    ),
    ProductList(
      Name: 'iPhone 12 pro',
      Price: 140000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "first.jpg",
    ),
    ProductList(
      Name: 'iPhone 13 pro',
      Price: 160000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "first.jpg",
    ),
    ProductList(
      Name: 'iPhone 14 pro',
      Price: 180000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "first.jpg",
    ),
    ProductList(
      Name: 'iPhone 15 pro',
      Price: 200000,
      ShortDescription:
      'The phone comes with a 5.80-inch touchscreen display offering a resolution of 1125x2436 pixels at a pixel density of 458 pixels per inch (ppi). iPhone 11 Pro is powered by a hexa-core Apple A13 Bionic processor. It comes with 4GB of RAM. The iPhone 11 Pro runs iOS 13 and is powered by a 3046mAh non-removable battery. ',
      ImageURL: "first.jpg",
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
      drawer: DrawerWidget(context,Colors.deepOrange),

      appBar: AppBar(

          leading: SearchButton
              ? IconButton(
              onPressed: () {
                setState(() {
                  SearchButton = false;
                  CustomSearch = const Icon(Icons.search,color: Colors.deepOrange,);
                  CustomText = const Text("Search");
                });
              },
              icon: const Icon(Icons.arrow_back_outlined,color: Colors.deepOrange,))
              : Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.deepOrange, // Change Custom Drawer Icon Color
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
            style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
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
                      CustomSearch = const Icon(Icons.clear,color: Colors.deepOrange,);
                      CustomText = TextField(
                        textInputAction: TextInputAction.go,
                        controller: search,
                        onChanged: (value) => onSearchTextChanged(value),
                        //onChanged: (Value) => updateList(Value),
                        decoration: const InputDecoration(
                            hintText: "Search....",
                            hintStyle: TextStyle(color: Colors.deepOrange),
                            //
                            border: UnderlineInputBorder()
                        ),
                        style: const TextStyle(color: Colors.deepOrange, fontSize: 20),
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
                  color: Colors.deepOrange,
                )),
            /*  IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.square_arrow_left,
                  color: Colors.indigo,
                )),*/

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
          Image.asset("oops.png"),
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
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(SearchItems[index].ImageURL),
                            // image: AssetImage('first.jpg'),
                            /* width: size.width / 2,
                                  height: size.height / 4,*/
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width/50,
                              ),
                              IconButton(
                                onPressed: decrement,
                                icon: const Icon(Icons.remove),
                                tooltip: "Item Remove",
                              ),
                              Text('$counter',style: const TextStyle(fontWeight: FontWeight.bold),),
                              IconButton(
                                onPressed: increment,
                                icon: const Icon(Icons.add),
                                tooltip: "Item added",
                              ),
                              SizedBox(
                                width: size.width/50,
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
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.heart,
                                  size: 15,
                                ),
                                tooltip: "Add to Favorite",
                              ),
                            ),
                            SizedBox(
                              width: size.width,
                              child:  AutoSizeText(
                                SearchItems[index].Name,
                                maxLines: 2,
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
                              child:  Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '₹${counter*SearchItems[index].Price}',
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
                              child:  AutoSizeText(
                                SearchItems[index].ShortDescription,
                                maxLines: 1,
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
                                        icon:
                                        const Icon(CupertinoIcons.delete))),
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
          Image.asset("oops.png"),
          const Text(
            "Search Item is not available ....!",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    )
        : ListView.builder(
        itemCount: MainData.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(MainData[index].ImageURL),
                            // image: AssetImage('first.jpg'),
                            /* width: size.width / 2,
                                  height: size.height / 4,*/
                          ),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width/50,
                              ),
                              IconButton(
                                onPressed: decrement,
                                icon: const Icon(Icons.remove),
                                tooltip: "Item Remove",
                              ),
                              Text('$counter',style: const TextStyle(fontWeight: FontWeight.bold),),
                              IconButton(
                                onPressed: increment,
                                icon: const Icon(Icons.add),
                                tooltip: "Item added",
                              ),
                              SizedBox(
                                width: size.width/50,
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
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.heart,
                                  size: 15,
                                ),
                                tooltip: "Add to Favorite",
                              ),
                            ),
                            SizedBox(
                              width: size.width,
                              child:  AutoSizeText(
                                MainData[index].Name,
                                maxLines: 2,
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
                              child:  Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '₹${counter*MainData[index].Price}',
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
                              child:  AutoSizeText(
                                MainData[index].ShortDescription,
                                maxLines: 1,
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
                                        icon:
                                        const Icon(CupertinoIcons.delete))),
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
