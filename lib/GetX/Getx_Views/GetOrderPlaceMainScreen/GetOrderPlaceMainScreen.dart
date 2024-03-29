import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Controller/GetxConfirmListController.dart';
import 'package:online_ordering_system/GetX/Getx_Controller/GetxFavoriteController.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import '../../Getx_Controller/GetxCartController.dart';
import '../../Getx_Utils/GetDrawer.dart';

class GetOrderPlaceMainScreen extends StatefulWidget {
  const GetOrderPlaceMainScreen({Key? key}) : super(key: key);

  @override
  State<GetOrderPlaceMainScreen> createState() =>
      _GetOrderPlaceMainScreenState();
}

class _GetOrderPlaceMainScreenState extends State<GetOrderPlaceMainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final placeOrderController = Get.put(GetxConfirmListController());
    placeOrderController.placeOrderAllDataAPI();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.put(GetxFavoriteController());
    return WillPopScope(
    onWillPop: () async{
      Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
      return false;
    },
      child: Scaffold(
        drawer: const GetDrawerWidget(),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
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
          title: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Center(
                child: Text(
              "Order Placed Items".tr,
              style: const TextStyle(color: Colors.black),
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
                              favoriteController
                                  .getFavoriteAddItemModelClass.data.length
                                  .toString(),
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
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    final confirmController = Get.put(GetxConfirmListController());

    return confirmController.placeOrderModelClass.data.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/oops.png"),
                Text(
                  "No any items purchase....!".tr,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          )
        : !confirmController.isLoading.value
            ? GetBuilder<GetxConfirmListController>(builder: (controller) {
                return GetBuilder<GetxCartController>(builder: (controller) {
                  return ListView.builder(
                      itemCount:
                          confirmController.placeOrderModelClass.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Image(
                                      image: NetworkImage(confirmController
                                          .placeOrderModelClass
                                          .data[index]
                                          .imageUrl),
                                      // fit: BoxFit.cover,
                                      width: Get.width / 2,
                                      height: Get.height / 5,
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
                                                "${'Order Place Date'.tr}:- ${confirmController.placeOrderModelClass.data[index].updatedAt}",
                                                textAlign: TextAlign.end,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              )),
                                          SizedBox(
                                            height: Get.height / 120,
                                          ),
                                          SizedBox(
                                            width: Get.width,
                                            child: AutoSizeText(
                                              confirmController
                                                  .placeOrderModelClass
                                                  .data[index]
                                                  .title,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 30),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height / 80,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  width: Get.width,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      '\$${confirmController.placeOrderModelClass.data[index].price}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  width: Get.width,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: AutoSizeText(
                                                      '${'Total Items added'.tr}:-${confirmController.placeOrderModelClass.data[index].quantity}',
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
                                            height: Get.height / 90,
                                          ),
                                          SizedBox(
                                            width: Get.width,
                                            child: AutoSizeText(
                                              confirmController
                                                  .placeOrderModelClass
                                                  .data[index]
                                                  .description,
                                              maxLines: 3,
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height / 90,
                                          ),
                                          /*  Row(
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
                                                                  .circular(
                                                                      5.0)),
                                                      child: const Center(
                                                          child: Text(
                                                        "Also Add in Cart",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      cartController.getAddToCart(
                                                          confirmController
                                                              .placeOrderModelClass
                                                              .data[index]
                                                              .productId);
                                                    },
                                                    child: Container(
                                                      width: Get.width,
                                                      height: Get.height / 20,
                                                      decoration: BoxDecoration(
                                                          color: Colors.indigo,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0)),
                                                      child: const Center(
                                                          child: Text(
                                                        "Again Add to Cart",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      )*/
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
                });
              })
            : const Center(child: CircularProgressIndicator());
  }
}
