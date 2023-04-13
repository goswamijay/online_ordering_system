import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:online_ordering_system/GetX/Getx_Controller/GetxCartController.dart';
import 'package:online_ordering_system/GetX/Getx_Controller/GetxFavoriteController.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';
import '../../Getx_Controller/GetxConfirmListController.dart';
import '../../Getx_Controller/GetxFirebaseApiCalling.dart';
import '../../Getx_Controller/GetxProductController.dart';
import '../../Getx_Utils/GetDrawer.dart';

class GetCartMainScreen extends StatefulWidget {
  const GetCartMainScreen({Key? key}) : super(key: key);

  @override
  State<GetCartMainScreen> createState() => _GetCartMainScreenState();
}

class _GetCartMainScreenState extends State<GetCartMainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cartController = Get.put(GetxCartController());
    cartController.getCartAllDataAPI();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());
    final orderPlaceController = Get.put(GetxConfirmListController());
    final firebaseApiCalling = Get.put(GetFirebaseApiCalling());


    return GetBuilder<GetxCartController>(
      builder: (controller) {
        return GetBuilder<GetxFavoriteController>(builder: (controller) {
          return GetBuilder<GetFirebaseApiCalling>(builder: (firebaseApiCalling1)
          {
            return Scaffold(
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
                title: const Padding(
                  padding: EdgeInsets.only(top: 5.0),
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
                                      shape: BoxShape.circle,
                                      color: Colors.red[900]),
                                  width: 34 / 2,
                                  height: 34 / 2,
                                  child: Text(
                                    favoriteController
                                        .getFavoriteAddItemModelClass.data
                                        .length
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
              // backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(246, 244, 244, 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16.0),
                              topLeft: Radius.circular(16.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: fullList1(context),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(246, 244, 244, 1),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Total Items (${cartController
                                        .getCartAddItemModelClass.data
                                        .length}) :-",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    " \$${cartController
                                        .getCartAddItemModelClass.cartTotal
                                        .toStringAsFixed(3)}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Text(
                                    "Total Price :- ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    " \$${cartController
                                        .getCartAddItemModelClass.cartTotal
                                        .toStringAsFixed(3)}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, bottom: 6.0, top: 6.0),
                      child: InkWell(
                        onTap: () {
                          cartController.getCartAddItemModelClass.data
                              .isNotEmpty
                              ? Get.defaultDialog(
                              title: "Confirm to Place Order",
                              middleText:
                              "You added ${cartController
                                  .getCartAddItemModelClass.data
                                  .length} Product and Total Price ${cartController
                                  .getCartAddItemModelClass.cartTotal
                                  .toStringAsFixed(3)}",
                              backgroundColor: Colors.white,
                              titleStyle:
                              const TextStyle(color: Colors.black),
                              middleTextStyle:
                              const TextStyle(color: Colors.black),
                              textConfirm: "Confirm",
                              textCancel: "Cancel",
                              cancelTextColor: Colors.black,
                              confirmTextColor: Colors.white,
                              buttonColor: Colors.indigo,
                              barrierDismissible: false,
                              radius: 10,
                              onConfirm: () async {
                                await orderPlaceController.getPlaceOrder(
                                    cartController.getCartAddItemModelClass
                                        .data[0].cartId
                                        .toString(),
                                    cartController
                                        .getCartAddItemModelClass.cartTotal
                                        .toString());
                                firebaseApiCalling1.sendPushNotification(
                                    "Online Ordering System",
                                    "You added ${cartController
                                        .getCartAddItemModelClass.data
                                        .length} Product and Total Price ${cartController
                                        .getCartAddItemModelClass
                                        .cartTotal.toStringAsFixed(3)}");
                                Future.delayed(const Duration(seconds: 0),
                                        () {
                                      cartController.getCartAllDataAPI();
                                      Get.back();

                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Lottie.asset(
                                                  height: 100,
                                                  width: 100,
                                                  'assets/Animation/placeholder.json'),
                                            );
                                          });
                                    });
                              },
                              onCancel: () {
                                Get.back();
                              })
                              : Get.defaultDialog(
                            title: "No Items Added in Cart",
                            middleText: "Please add item in cart",
                            backgroundColor: Colors.white,
                            titleStyle:
                            const TextStyle(color: Colors.black),
                            middleTextStyle:
                            const TextStyle(color: Colors.black),
                            textConfirm: "Okay",
                            cancelTextColor: Colors.black,
                            confirmTextColor: Colors.white,
                            buttonColor: Colors.indigo,
                            barrierDismissible: false,
                            radius: 10,
                            onConfirm: () {
                              Get.back();
                            },
                          );
                        },
                        child: Container(
                          height: Get.height / 15,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Center(
                              child: Text(
                                "Place Order ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
      },
    );
  }

  Widget fullList1(BuildContext context) {
    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());
    final productController = Get.put(GetxProductController());

    return cartController.getCartAddItemModelClass.data.isEmpty
        ? Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              //  Image.asset("assets/cart.gif"),
                Image.asset(
                  "assets/cart1.png",
                  height: Get.height / 2,
                  width: Get.width / 2,
                ),
                const Center(
                  child: Text(
                    "No Items added in cart ....!",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          )
        : GetBuilder<GetxCartController>(builder: (controller) {
            return GetBuilder<GetxProductController>(builder: (controller) {
              return GetBuilder<GetxFavoriteController>(builder: (controller) {
                return  !cartController.isLoading.value ?ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    //  shrinkWrap: true,

                    itemCount:
                        cartController.getCartAddItemModelClass.data.length,
                    itemBuilder: (context, index) {

                      return Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Image(
                                          image: NetworkImage(cartController
                                              .getCartAddItemModelClass
                                              .data[index]
                                              .productDetails!
                                              .imageUrl),
                                          width: Get.width / 2,
                                          height: Get.height / 5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 5.0,
                                        bottom: 8.0,
                                        top: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: productController
                                                          .getProductAllAPI
                                                          .data[index]
                                                          .watchListItemId !=
                                                      ''
                                                  ? InkWell(
                                                      onTap: () async {
                                                        await favoriteController
                                                            .getRemoveFavorite(
                                                                productController
                                                                    .getProductAllAPI
                                                                    .data[index]
                                                                    .watchListItemId);
                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    0),
                                                            () async {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .hideCurrentSnackBar();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                "Product Remove From Favorite!",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.indigo,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                            ),
                                                          );
                                                          await productController
                                                              .productAllAPI();
                                                        });
                                                      },
                                                      child: const Icon(
                                                        CupertinoIcons
                                                            .heart_solid,
                                                        size: 16,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () async {
                                                        await favoriteController
                                                            .getAddInFavorite(
                                                                cartController
                                                                    .getCartAddItemModelClass
                                                                    .data[index]
                                                                    .productDetails!
                                                                    .id);
                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    0),
                                                            () async {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .hideCurrentSnackBar();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                "Product Added To Favorite!",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.indigo,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                            ),
                                                          );
                                                          await productController
                                                              .productAllAPI();
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
                                          width: Get.width,
                                          child: AutoSizeText(
                                            cartController
                                                .getCartAddItemModelClass
                                                .data[index]
                                                .productDetails!
                                                .title,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 30),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height / 70,
                                        ),
                                        SizedBox(
                                          width: Get.width,
                                          child: AutoSizeText(
                                            cartController
                                                .getCartAddItemModelClass
                                                .data[index]
                                                .productDetails!
                                                .description,
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
                                              child: SizedBox(
                                                width: Get.width,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: AutoSizeText(
                                                    '\$${cartController.getCartAddItemModelClass.data[index].productDetails!.price}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                  onPressed: () async {
                                                    await cartController
                                                        .removeProductFromCart(
                                                            cartController
                                                                .getCartAddItemModelClass
                                                                .data[index]
                                                                .id);
                                                    await cartController
                                                        .getCartAllDataAPI();
                                                  },
                                                  icon: const Icon(
                                                      CupertinoIcons.delete)),
                                            ),
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    //onTap: CartProvider.decrement(CartProvider.PurchaseList[index].Count),
                                                    onTap: () async {
                                                      await cartController
                                                          .decreaseProductQuantity(
                                                              cartController
                                                                  .getCartAddItemModelClass
                                                                  .data[index]
                                                                  .id);
                                                      await cartController
                                                          .getCartAllDataAPI();
                                                    },

                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      radius: 14,
                                                      child: const Center(
                                                          child: Icon(
                                                        Icons.remove,
                                                        color: Colors.black,
                                                      )),
                                                    ),
                                                  ),
                                                  Text(
                                                    cartController
                                                        .getCartAddItemModelClass
                                                        .data[index]
                                                        .quantity
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await cartController
                                                          .increaseProductQuantity(
                                                              cartController
                                                                  .getCartAddItemModelClass
                                                                  .data[index]
                                                                  .id);
                                                      await cartController
                                                          .getCartAllDataAPI();
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey[200],
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
                    }) :const CircularProgressIndicator();
              });
            });
          });
  }
}
