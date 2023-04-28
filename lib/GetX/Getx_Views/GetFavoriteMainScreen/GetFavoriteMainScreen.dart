import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_ordering_system/GetX/Getx_Utils/Getx_Routes_Name.dart';

import '../../Getx_Controller/GetxCartController.dart';
import '../../Getx_Controller/GetxFavoriteController.dart';
import '../../Getx_Controller/GetxProductController.dart';
import '../../Getx_Utils/GetDrawer.dart';

class GetFavoriteMainScreen extends StatefulWidget {
  const GetFavoriteMainScreen({Key? key}) : super(key: key);

  @override
  State<GetFavoriteMainScreen> createState() => _GetFavoriteMainScreenState();
}

class _GetFavoriteMainScreenState extends State<GetFavoriteMainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final favoriteController = Get.put(GetxFavoriteController());
    favoriteController.favoriteAllDataAPI();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(GetxCartController());
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
        title:  Padding(
          padding:const EdgeInsets.only(top: 5.0),
          child: Center(
              child: Text(
            'Favorite Items'.tr,
            style: const TextStyle(color: Colors.black),
          )),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 12.0, top: 12.0),
              child:  GetBuilder<GetxCartController>(builder: (controller) {
                return  InkWell(
                  onTap: () {
                    Get.toNamed(
                        GetxRoutes_Name.GetxCartMainScreen);
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
                                cartController.getCartAddItemModelClass.data.length
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),),
        ],
      ),
      backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: fullList1(context),
          ),
        ),
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartController = Get.put(GetxCartController());
    final favoriteController = Get.put(GetxFavoriteController());

    return favoriteController.getFavoriteAddItemModelClass.data.isEmpty
        ? Container(
            height: size.height,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/favourite.gif"),
                 Text(
                  'Not any items added in Favorite ....!'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          )
        : !favoriteController.isLoading.value ? GetBuilder<GetxFavoriteController>(builder: (controller) {
            return GetBuilder<GetxProductController>(builder: (controller) {
              return GetBuilder<GetxCartController>(builder: (controller) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: favoriteController
                        .getFavoriteAddItemModelClass.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Image(
                                    image: NetworkImage(favoriteController
                                        .getFavoriteAddItemModelClass
                                        .data[index]
                                        .productDetails
                                        .imageUrl),
                                    width: size.width / 2,
                                    height: size.height / 5,
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
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: favoriteController
                                                      .getFavoriteAddItemModelClass
                                                      .data[index]
                                                      .id !=
                                                  ''
                                              ? InkWell(
                                                  onTap: () {
                                                    favoriteController
                                                        .getRemoveFavorite(
                                                            favoriteController
                                                                .getFavoriteAddItemModelClass
                                                                .data[index]
                                                                .id);

                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 0), () {
                                                      //   accessApi(context);
                                                      favoriteController
                                                          .favoriteAllDataAPI();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                         SnackBar(
                                                          content: Text(
                                                            'Product Remove From Favorite!'.tr,
                                                            style:  const TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          backgroundColor:
                                                              Colors.indigo,
                                                          duration: const  Duration(
                                                              seconds: 1),
                                                        ),
                                                      );
                                                    });
                                                  },
                                                  child: const Icon(
                                                    CupertinoIcons.heart_solid,
                                                    color: Colors.red,
                                                    size: 18,
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                       SnackBar(
                                                        content: Text(
                                                          'Product Added To Favorite!'.tr,
                                                          style: const TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        backgroundColor:
                                                            Colors.indigo,
                                                        duration:const Duration(
                                                            seconds: 1),
                                                      ),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    CupertinoIcons.heart,
                                                    size: 18,
                                                  ),
                                                ),
                                        ),
                                        SizedBox(
                                          width: size.width,
                                          child: AutoSizeText(
                                            favoriteController
                                                .getFavoriteAddItemModelClass
                                                .data[index]
                                                .productDetails
                                                .title,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 30),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height / 90,
                                        ),
                                        SizedBox(
                                          width: size.width,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              '\$${favoriteController.getFavoriteAddItemModelClass.data[index].productDetails.price}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height / 90,
                                        ),
                                        SizedBox(
                                          width: size.width,
                                          child: AutoSizeText(
                                            favoriteController
                                                .getFavoriteAddItemModelClass
                                                .data[index]
                                                .productDetails
                                                .description,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 30),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height / 60,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: favoriteController
                                                            .getFavoriteAddItemModelClass
                                                            .data[index]
                                                            .cartId !=
                                                        ''
                                                    ? InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          width: size.width,
                                                          height:
                                                              size.height / 20,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.pink,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                          child:  Center(
                                                              child: Text(
                                                            'Added in Cart'.tr,
                                                            style:const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          cartController.addToCart(
                                                              favoriteController
                                                                      .favoriteData[
                                                                  index]);
                                                        },
                                                        child: Container(
                                                          width: size.width,
                                                          height:
                                                              size.height / 20,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.indigo,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                          child:  Center(
                                                              child: Text(
                                                            'Add to Cart'.tr,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        ),
                                                      ))
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
              });
            });
          }) :const CircularProgressIndicator();
  }
}
