import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Getx_Controller/GetxCartController.dart';
import '../../Getx_Controller/GetxFavoriteController.dart';
import '../../Getx_Controller/GetxProductController.dart';
import '../../Getx_Utils/Getx_Routes_Name.dart';

class GetDetailsProductScreen extends StatefulWidget {
  const GetDetailsProductScreen({Key? key}) : super(key: key);

  @override
  State<GetDetailsProductScreen> createState() =>
      _GetDetailsProductScreenState();
}

class _GetDetailsProductScreenState extends State<GetDetailsProductScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic argument = Get.arguments;

    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());
    final productController = Get.put(GetxProductController());

    return GetBuilder<GetxFavoriteController>(builder: (controller) {
      return GetBuilder<GetxCartController>(builder: (controller) {
        return GetBuilder<GetxProductController>(builder: (controller){
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Colors.black,
                                ),
                              )),
                          InkWell(
                            onTap: () {
                              Get.toNamed(GetxRoutes_Name.GetxCartMainScreen);

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
                                        CupertinoIcons.cart_fill,
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
                                          productController.getProductAllAPI.totalProduct.toString(),
                                          textAlign: TextAlign.center,
                                          style:
                                          const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(
                        children: [
                          Container(
                            width: Get.width,
                            height: Get.height / 2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Image(
                              image: NetworkImage(argument!['ImageURL']),
                              // image: AssetImage('first.jpg'),
                              width: Get.width / 2,
                              height: Get.height / 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: productController
                                  .getProductAllAPI
                                  .data[argument!['Index']]
                                  .watchListItemId !=
                                  ''
                                  ? InkWell(
                                onTap: () async{
                                await  favoriteController
                                      .getRemoveFavorite(
                                      productController
                                          .getProductAllAPI
                                          .data[argument!['Index']]
                                          .watchListItemId);
                                await productController.productAllAPI();
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                      content: Text(
                                        "Product Remove From Favorite!".tr,
                                        style:const TextStyle(fontSize: 16),
                                      ),
                                      backgroundColor: Colors.indigo,
                                      duration:const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  CupertinoIcons.heart_solid,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              )
                                  : InkWell(
                                onTap: () async {
                                  await favoriteController
                                      .getAddInFavorite(
                                      productController
                                          .getProductAllAPI
                                          .data[argument!['Index']]
                                          .id);
                                  await productController.productAllAPI();

                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                      content: Text(
                                        "Product Added To Favorite!".tr,
                                        style:const TextStyle(fontSize: 16),
                                      ),
                                      backgroundColor: Colors.indigo,
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  CupertinoIcons.heart,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: Get.width,
                              child: AutoSizeText(
                                argument!['Name'].toString(),
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 30),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text("4.5"),
                              Icon(
                                Icons.star,
                                color: Colors.yellow[900],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                      child: SizedBox(
                        width: Get.width,
                        child: AutoSizeText(
                          argument!['ShortDescription'].toString(),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: Get.width,
                        child: AutoSizeText(
                          '\$${argument!['Price']}',
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: productController
                          .getProductAllAPI
                          .data[argument!['Index']]
                          .quantity !=
                          0
                          ? InkWell(
                        onTap: () {},
                        child: Container(
                          width: Get.width,
                          height: Get.height / 15,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(5.0)),
                          child:  Center(
                              child: Text(
                                "Added in Cart".tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      )
                          : InkWell(
                        onTap: () async{
                          await cartController
                              .getAddToCart(
                              productController
                                  .getProductAllAPI
                                  .data[
                              argument!['Index']]
                                  .id);
                          await productController.productAllAPI();
                        },
                        onDoubleTap: () {},
                        onLongPress: () {},
                        child: Container(
                          width: Get.width,
                          height: Get.height / 15,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(5.0)),
                          child:  Center(
                              child: Text(
                                "Add to Cart".tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
    });
  }
}
