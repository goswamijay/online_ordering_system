import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_ordering_system/Controller/Favorite_add_provider.dart';
import 'package:provider/provider.dart';

import '../../Controller/ApiConnection/mainDataProvider.dart';
import '../../Controller/place_Order_Items.dart';
import '../../Controller/Cart_items_provider.dart';
import '../../Utils/Drawer.dart';
import '../../Utils/Routes_Name.dart';

class OrderPlaceMainScreen extends StatefulWidget {
  const OrderPlaceMainScreen({Key? key}) : super(key: key);

  @override
  State<OrderPlaceMainScreen> createState() => _OrderPlaceMainScreenState();
}

class _OrderPlaceMainScreenState extends State<OrderPlaceMainScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      accessApi(context);
    });
  }

  accessApi(BuildContext context) async {
    final apiConnection1 =
        Provider.of<PlaceOrderProvider>(context, listen: false);
    final favoriteProvider =
    Provider.of<FavoriteAddProvider>(context, listen: false);


    favoriteProvider.showItemBool = false;
    apiConnection1.showItemBool = false;
    await favoriteProvider.favoriteAllDataAPI(context);
    await apiConnection1.placeOrderAllDataAPI(context);
    apiConnection1.showItem();
    favoriteProvider.showItem();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteAddProvider>(context);
    final placeOrderProvider = Provider.of<PlaceOrderProvider>(context);
    final mainDataProvider = Provider.of<ApiConnection>(context, listen: false);

    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
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
                          child: placeOrderProvider.showItemBool
                              ? Text(
                                  favoriteProvider.favoriteData.data.length
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                )
                              : const CircularProgressIndicator(),
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
        child: placeOrderProvider.showItemBool || mainDataProvider.showItemBool
            ? fullList1(context)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final confirmProvider = Provider.of<PlaceOrderProvider>(context);
    final cartProvider = Provider.of<cart_items_provider>(context);
    final mainDataProvider = Provider.of<ApiConnection>(context, listen: false);


    return confirmProvider.confirmList.data.isEmpty
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
        : ListView.builder(
            itemCount: confirmProvider.confirmList.data.length,
            itemBuilder: (context, index) {
              bool isAddedInCart = false;
            /*  List<bool> isAddedInCart = [];
                for(int j = 0; j < cartProvider.addCartItem[0].data.length ; j++){
                   isAddedInCart = [(confirmProvider.confirmList.data[index].imageUrl.toString() == cartProvider.addCartItem[0].data[j].productDetails.imageUrl.toString())];
                }*/

              /*  bool isAddedInCart = cartProvider.PurchaseList.any((element1) =>
                  element1.Name.contains(
                      confirmProvider.ConfirmList[index].Name));*/
              return InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushNamed(context, Routes_Name.ProductDetailsScreen,
                      arguments: {
                        'Price': confirmProvider.confirmList.data[index].price,
                        'Name': confirmProvider.confirmList.data[index].title,
                        'ImageURL':
                            confirmProvider.confirmList.data[index].imageUrl,
                        'ShortDescription':
                            confirmProvider.confirmList.data[index].description,
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
                              image: NetworkImage(confirmProvider
                                  .confirmList.data[index].imageUrl),
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
                                        "Order Place Date:- ${confirmProvider.confirmList.data[index].updatedAt}",
                                        textAlign : TextAlign.end,
                                        maxLines: 2
                                        ,
                                      )),
                                  SizedBox(
                                    height: size.height / 100,
                                  ),
                                  SizedBox(
                                    width: size.width,
                                    child: AutoSizeText(
                                      confirmProvider
                                          .confirmList.data[index].title,
                                      maxLines: 1,
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
                                        flex: 1,
                                        child: SizedBox(
                                          width: size.width,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              '\$${confirmProvider.confirmList.data[index].price}',
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
                                              'Total Items added:-${confirmProvider.confirmList.data[index].quantity}',
                                              style:
                                                  const TextStyle(fontSize: 18),
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
                                      confirmProvider
                                          .confirmList.data[index].description,
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
                                        child: /*mainDataProvider
                                            .productAll[0]
                                            .data[index]
                                            .quantity !=
                                            0*/
                                        isAddedInCart
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
                                                  cartProvider.productAllAPI(
                                                      confirmProvider
                                                          .confirmList
                                                          .data[index]
                                                          .productId);
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
                                                    "Again Add to Cart",
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
