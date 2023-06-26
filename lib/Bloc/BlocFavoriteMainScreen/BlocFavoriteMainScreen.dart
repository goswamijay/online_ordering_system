import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BlocCartMainScreen/BlocCartMainScreen.dart';
import '../BlocCartMainScreen/BlocCartScreenCubit.dart';
import '../BlocCartMainScreen/BlocCartScreenState.dart';
import '../BlocProductMainScreen/BlocProductMainScreenCubit.dart';
import '../BlocProductMainScreen/BlocProductMainScreenState.dart';
import 'BlocFavoriteScreenCubit.dart';
import 'BlocFavoriteScreenState.dart';

class BlocFavoriteMainScreen extends StatelessWidget {
  const BlocFavoriteMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocFavoriteScreenCubit favoriteController = BlocProvider.of<BlocFavoriteScreenCubit>(context);
    favoriteController.favoriteAllDataAPI();
    return WillPopScope(
      onWillPop: () async{
     //   Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
        return false;
      },
      child: Scaffold(
       // drawer: const GetDrawerWidget(),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: InkWell(
                onTap: () {
                  //Get.offAllNamed(GetxRoutes_Name.GetxHomePage);
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
          title:  const Padding(
            padding:EdgeInsets.only(top: 5.0),
            child: Center(
                child: Text(
                  'Favorite Items',
                  style: TextStyle(color: Colors.black),
                )),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const BlocCartMainScreen()));
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
                        BlocBuilder<BlocProductMainScreenCubit,
                            BlocProductMainScreenState>(
                          builder: (BuildContext context, state) {
                            BlocProductMainScreenCubit productController =
                            BlocProvider.of<
                                BlocProductMainScreenCubit>(context);
                            return Positioned(
                              right: 0,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red[900]),
                                  width: 34 / 2,
                                  height: 34 / 2,
                                  child: Text(
                                    productController
                                        .getProductAllAPI.totalProduct
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )),

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
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocCartScreenCubit cartController = BlocProvider.of<BlocCartScreenCubit>(context);
    BlocFavoriteScreenCubit favoriteController = BlocProvider.of<BlocFavoriteScreenCubit>(context);

    return favoriteController.blocFavoriteAddItemModelClass.data.isEmpty
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
          const Text(
            'Not any items added in Favorite ....!',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    )
        :

    BlocConsumer<BlocCartScreenCubit, BlocCartScreenState>(
        builder: (builder, state) {

          return BlocConsumer<BlocProductMainScreenCubit,
              BlocProductMainScreenState>(
              builder: (builder, state) {
                return BlocConsumer<BlocFavoriteScreenCubit,
                    BlocFavoriteScreenState>(
                    builder: (builder, state) {
                      return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: favoriteController
                  .blocFavoriteAddItemModelClass.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Image(
                              image: NetworkImage(favoriteController
                                  .blocFavoriteAddItemModelClass
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
                                        .blocFavoriteAddItemModelClass
                                        .data[index]
                                        .id !=
                                        ''
                                        ? InkWell(
                                      onTap: () {
                                        favoriteController
                                            .getRemoveFavorite(
                                            favoriteController
                                                .blocFavoriteAddItemModelClass
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
                                            const SnackBar(
                                              content: Text(
                                                'Product Remove From Favorite!',
                                                style:  TextStyle(
                                                    fontSize: 16),
                                              ),
                                              backgroundColor:
                                              Colors.indigo,
                                              duration: Duration(
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
                                          const SnackBar(
                                            content: Text(
                                              'Product Added To Favorite!',
                                              style: TextStyle(
                                                  fontSize: 16),
                                            ),
                                            backgroundColor:
                                            Colors.indigo,
                                            duration:Duration(
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
                                          .blocFavoriteAddItemModelClass
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
                                        '\$${favoriteController.blocFavoriteAddItemModelClass.data[index].productDetails.price}',
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
                                          .blocFavoriteAddItemModelClass
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
                                              .blocFavoriteAddItemModelClass
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
                                              child:  const Center(
                                                  child: Text(
                                                    'Added in Cart',
                                                    style:TextStyle(
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
                                              child:  const Center(
                                                  child: Text(
                                                    'Add to Cart',
                                                    style: TextStyle(
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
                    },
                    listener: (listener, state) {});
              },
              listener: (listener, state) {});
        },
        listener: (listener, state) {});
  }
}