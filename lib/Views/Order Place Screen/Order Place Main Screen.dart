import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Controller/Favorite_add_provider.dart';
import 'package:provider/provider.dart';

import '../../Controller/Confirm_Order_Items.dart';
import '../../Controller/Purchase_items_provider.dart';
import '../../Models/FavoriteListModelClass.dart';
import '../../Utils/Drawer.dart';
import '../../Utils/Routes_Name.dart';

class OrderPlaceMainScreen extends StatefulWidget {
  const OrderPlaceMainScreen({Key? key}) : super(key: key);

  @override
  State<OrderPlaceMainScreen> createState() => _OrderPlaceMainScreenState();
}

class _OrderPlaceMainScreenState extends State<OrderPlaceMainScreen> {

  @override
  Widget build(BuildContext context) {

    final FavoriteProvider = Provider.of<Favorite_add_provider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(context,Colors.indigo!),
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
                "Order Placed Items",
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
      backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FullList1(context),
      ),
    );
  }


  Widget FullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ConfirmProvider = Provider.of<Place_order_Provider>(context);
    final CartProvider = Provider.of<Purchase_items_provider>(context);


    return ConfirmProvider.ConfirmList.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/oops.png"),
          const Text(
            "No any items purchase....!",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    )
        :
    ListView.builder(
        itemCount: ConfirmProvider.ConfirmList.length,
        itemBuilder: (context, index) {

          bool isAddedInCart = CartProvider.PurchaseList.any(
                  (element1) => element1.Name.contains(ConfirmProvider.ConfirmList[index].Name));
          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage(ConfirmProvider.ConfirmList[index].ImageURL),
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
                                child: AutoSizeText(
                                 // "Order Place Date:- ${DateTime.parse("2023-03-10")}",
                                  "Order Place Date:- ${ConfirmProvider.ConfirmList[index].dateTime}",

                                  maxLines: 1,)),

                            SizedBox(
                              height: size.height / 70,
                            ),
                            SizedBox(
                              width: size.width,
                              child: AutoSizeText(
                                ConfirmProvider.ConfirmList[index].Name,
                                maxLines: 1,
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
                                  flex: 1,
                                  child: SizedBox(
                                    width: size.width,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '₹${ConfirmProvider.ConfirmList[index].Price*ConfirmProvider.ConfirmList[index].Count}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: SizedBox(
                                    width: size.width,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: AutoSizeText(

                                          'Total Items added:-${ConfirmProvider.ConfirmList[index].Count}',
                                          style: const TextStyle(
                                              fontSize: 18),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height / 70,
                            ),
                            SizedBox(
                              width: size.width,
                              child: AutoSizeText(
                                ConfirmProvider.ConfirmList[index].ShortDescription,
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
                                              ConfirmProvider.ConfirmList[index].Price,
                                              Name: ConfirmProvider.ConfirmList[index].Name,
                                              ShortDescription:
                                              ConfirmProvider.ConfirmList[index]
                                                  .ShortDescription,
                                              ImageURL: ConfirmProvider.ConfirmList[index]
                                                  .ImageURL));
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
                                            "Again Add to Cart",
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

