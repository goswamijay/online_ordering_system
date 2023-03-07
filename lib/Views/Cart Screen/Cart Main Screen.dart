import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Controller/Favorite_add_provider.dart';
import 'package:online_ordering_system/Controller/Confirm_Order_Items.dart';
import 'package:provider/provider.dart';

import '../../Models/ConfirmListModelClass.dart';
import '../../Models/FavoriteListModelClass.dart';
import '../../Controller/Purchase_items_provider.dart';
import '../../Utils/Drawer.dart';
import '../../Utils/Routes_Name.dart';

class CartMainScreen extends StatefulWidget {
  const CartMainScreen({Key? key}) : super(key: key);

  @override
  State<CartMainScreen> createState() => _CartMainScreenState();
}

class _CartMainScreenState extends State<CartMainScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider = Provider.of<Purchase_items_provider>(context);
    final FavoriteProvider = Provider.of<Favorite_add_provider>(context);
    final ConfirmProvider = Provider.of<Place_order_Provider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(context, Colors.indigo),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(Routes_Name.HomePage);
              },
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 12.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes_Name.FavoriteMainScreen);
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
                          CupertinoIcons.heart_solid,
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
                          child: Text(
                            FavoriteProvider.FavoriteList.length.toString(),
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
      // backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(246, 244, 244, 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0),
                      topLeft: Radius.circular(16.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FullList1(context),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                height: size.height / 20,
                color: Colors.orange,
                child: Center(
                    child: Text(
                  "Total Price :- ${CartProvider.AllItemPrice().toString()}",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                print(CartProvider.PurchaseList.length);
                setState(() {
                  for (int index = 0;
                      index < CartProvider.PurchaseList.length;
                      index++) {
                    ConfirmProvider.AddItems(ConfirmListModelClass(
                        Price: CartProvider.PurchaseList[index].Price,
                        Name: CartProvider.PurchaseList[index].Name,
                        ShortDescription:
                            CartProvider.PurchaseList[index].ShortDescription,
                        ImageURL: CartProvider.PurchaseList[index].ImageURL,
                        Count: CartProvider.PurchaseList[index].Count,
                        dateTime: DateTime.now()));

                    print(ConfirmProvider.ConfirmList[index].Name);
                  }
                  CartProvider.cleanCartItem();
                }); // ConfirmProvider.AddItems()
              },
              child: Container(
                height: size.height / 20,
                color: Colors.indigo,
                child: const Center(
                    child: Text(
                  "Place Order",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget FullList1(BuildContext context) {
    final CartProvider = Provider.of<Purchase_items_provider>(context);
    final FavoriteProvider = Provider.of<Favorite_add_provider>(context);
    final ConfirmProvider = Provider.of<Place_order_Provider>(context);

    Size size = MediaQuery.of(context).size;
    return CartProvider.PurchaseList.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/oops.png"),
                const Center(
                  child: Text(
                    "Search Item is not available ....!",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: CartProvider.PurchaseList.length,
            itemBuilder: (context, index) {
              bool isSaved = FavoriteProvider.FavoriteList.any((element) =>
                  element.Name.contains(CartProvider.PurchaseList[index].Name));

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
                                  image: AssetImage(CartProvider
                                      .PurchaseList[index].ImageURL),
                                  // image: AssetImage('first.jpg'),
                                  width: size.width / 2,
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
                                                  FavoriteProvider
                                                      .RemoveFavoriteItems(
                                                          FavoriteProvider
                                                                  .FavoriteList[
                                                              index]);
                                                });
                                              },
                                              child: const Icon(
                                                CupertinoIcons.heart_solid,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                setState(() {
                                                  FavoriteProvider.AddFavoriteItems(
                                                      FavoriteListModelClass(
                                                          Price: CartProvider
                                                              .PurchaseList[
                                                                  index]
                                                              .Price,
                                                          Name: CartProvider
                                                              .PurchaseList[
                                                                  index]
                                                              .Name,
                                                          ShortDescription:
                                                              CartProvider
                                                                  .PurchaseList[
                                                                      index]
                                                                  .ShortDescription,
                                                          ImageURL: CartProvider
                                                              .PurchaseList[
                                                                  index]
                                                              .ImageURL));
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
                                    CartProvider.PurchaseList[index].Name,
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
                                  child: AutoSizeText(
                                    CartProvider
                                        .PurchaseList[index].ShortDescription,
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
                                            '₹${CartProvider.PurchaseList[index].Count * CartProvider.PurchaseList[index].Price}',
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
                                          onPressed: () {
                                            CartProvider.RemoveToCart(
                                                CartProvider
                                                    .PurchaseList[index]);
                                          },
                                          icon: const Icon(
                                              CupertinoIcons.delete)),
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            //onTap: CartProvider.decrement(CartProvider.PurchaseList[index].Count),
                                            onTap: () {
                                              setState(() {
                                                if (CartProvider
                                                        .PurchaseList[index]
                                                        .Count >
                                                    1) {
                                                  CartProvider
                                                      .PurchaseList[index]
                                                      .Count--;
                                                  print(CartProvider
                                                      .PurchaseList[index]
                                                      .Count);
                                                }
                                              });
                                            },

                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey[200],
                                              radius: 14,
                                              child: const Center(
                                                  child: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ),
                                          Text(
                                            CartProvider
                                                .PurchaseList[index].Count
                                                .toString(),
                                            //CartProvider.counter.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          InkWell(
                                            /*     onTap: (){CartProvider.increment(CartProvider.PurchaseList[index].Count);},*/
                                            onTap: () {
                                              setState(() {
                                                CartProvider.PurchaseList[index]
                                                    .Count++;
                                                print(CartProvider
                                                    .PurchaseList[index].Count);
                                              });
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey[200],
                                              radius: 14,
                                              child: const Center(
                                                  child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              )),
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
