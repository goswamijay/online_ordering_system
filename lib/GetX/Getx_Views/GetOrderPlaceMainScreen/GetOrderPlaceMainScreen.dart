import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Controller/GetxConfirmListController.dart';
import 'package:online_ordering_system/GetX/Getx_Controller/GetxFavoriteController.dart';
import 'package:online_ordering_system/GetX/Getx_Models/GetxProductModel.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';

import '../../../Utils/Drawer.dart';
import '../../Getx_Controller/GetxCartController.dart';

class GetOrderPlaceMainScreen extends StatefulWidget {
  const GetOrderPlaceMainScreen({Key? key}) : super(key: key);

  @override
  State<GetOrderPlaceMainScreen> createState() =>
      _GetOrderPlaceMainScreenState();
}

class _GetOrderPlaceMainScreenState extends State<GetOrderPlaceMainScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.put(GetxFavoriteController());
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: InkWell(
              onTap: () {
                Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
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
                Get.toNamed(GetxRoutes_Name.GetxFavoriteMainScreen);
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
                            favoriteController.favoriteData.length.toString(),
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
        child: fullList1(context),
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    final confirmController = Get.put(GetxConfirmListController());
    final cartController = Get.put(GetxCartController());

    return confirmController.confirmData.isEmpty
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
        : GetBuilder<GetxConfirmListController>(builder: (controller) {
          return GetBuilder<GetxCartController>(builder: (controller){
            return ListView.builder(
                itemCount: confirmController.confirmData.length,
                itemBuilder: (context, index) {
                 /* bool isAddedInCart = cartController.cartData
                      .contains(confirmController.confirmData[index]);*/

                  bool isAddedInCart = cartController.cartData.any(
                          (element1) => element1.Name.contains(confirmController.confirmData[index].Name));
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Image(
                                image: AssetImage(confirmController
                                    .confirmData[index].ImageURL),
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
                                        child: AutoSizeText(
                                          // "Order Place Date:- ${DateTime.parse("2023-03-10")}",
                                          "Order Place Date:- ${confirmController.confirmData[index].dateTime}",

                                          maxLines: 1,
                                        )),
                                    SizedBox(
                                      height: Get.height / 70,
                                    ),
                                    SizedBox(
                                      width: Get.width,
                                      child: AutoSizeText(
                                        confirmController
                                            .confirmData[index].Name,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 30),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height / 70,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            width: Get.width,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                '₹${confirmController.confirmData[index].Price * confirmController.confirmData[index].Count}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: Get.width,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: AutoSizeText(
                                                'Total Items added:-${confirmController.confirmData[index].Count}',
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
                                      height: Get.height / 70,
                                    ),
                                    SizedBox(
                                      width: Get.width,
                                      child: AutoSizeText(
                                        confirmController.confirmData[index]
                                            .ShortDescription,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 30),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height / 70,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: isAddedInCart
                                              ? InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: Get.width,
                                                    height: Get.height / 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.pink,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
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
                                                    cartController.addToCart(GetxProduct(
                                                        Price: confirmController
                                                            .confirmData[index]
                                                            .Price,
                                                        Name: confirmController
                                                            .confirmData[index]
                                                            .Name,
                                                        ShortDescription:
                                                            confirmController
                                                                .confirmData[
                                                                    index]
                                                                .ShortDescription,
                                                        ImageURL:
                                                            confirmController
                                                                .confirmData[
                                                                    index]
                                                                .ImageURL));
                                                  },
                                                  child: Container(
                                                    width: Get.width,
                                                    height: Get.height / 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.indigo,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
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
                  );
                });
          });});
  }
}
