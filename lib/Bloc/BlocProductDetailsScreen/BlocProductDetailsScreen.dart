import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:online_ordering_system/Bloc/BlocCartMainScreen/BlocCartScreenCubit.dart';
import 'package:online_ordering_system/Bloc/BlocCartMainScreen/BlocCartScreenState.dart';
import 'package:online_ordering_system/Bloc/BlocFavoriteMainScreen/BlocFavoriteScreenCubit.dart';
import 'package:online_ordering_system/Bloc/BlocProductMainScreen/BlocProductMainScreenCubit.dart';
import 'package:online_ordering_system/Bloc/BlocProductMainScreen/BlocProductMainScreenState.dart';

import '../BlocFavoriteMainScreen/BlocFavoriteScreenState.dart';

class BlocProductDetailsScreen extends StatefulWidget {
  const BlocProductDetailsScreen(
      {super.key,
      required this.price,
      required this.name,
      required this.imageURL,
      required this.shortDescription,
      required this.index});

  final String price;
  final String name;

  final String imageURL;
  final String shortDescription;
  final int index;

  @override
  State<BlocProductDetailsScreen> createState() =>
      _BlocProductDetailsScreenState();
}

class _BlocProductDetailsScreenState extends State<BlocProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    BlocProductMainScreenCubit productController =
        BlocProvider.of<BlocProductMainScreenCubit>(context);
    BlocFavoriteScreenCubit favoriteController =
        BlocProvider.of<BlocFavoriteScreenCubit>(context);
    BlocCartScreenCubit cartController =
        BlocProvider.of<BlocCartScreenCubit>(context);

    return BlocConsumer<BlocFavoriteScreenCubit, BlocFavoriteScreenState>(
      builder: (controller, state) {
        return BlocConsumer<BlocCartScreenCubit, BlocCartScreenState>(
          builder: (controller, state) {
            return BlocConsumer<BlocProductMainScreenCubit,
                BlocProductMainScreenState>(
              builder: (controller, state) {
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, top: 12.0, right: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
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
                                    //  Get.toNamed(GetxRoutes_Name.GetxCartMainScreen);
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
                                                productController
                                                    .getProductAllAPI
                                                    .totalProduct
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
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: size.width,
                                  height: size.height / 2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Image(
                                    image: NetworkImage(widget.imageURL),
                                    width: size.width / 2,
                                    height: size.height / 2,
                                  ),
                                ),
                                BlocConsumer<BlocFavoriteScreenCubit,
                                        BlocFavoriteScreenState>(
                                    builder: (builder, state) {
                                  BlocFavoriteScreenCubit favoriteController =
                                      BlocProvider.of<BlocFavoriteScreenCubit>(
                                          context);

                                  if (state is BlocFavoriteLoadingState) {
                                    if (productController
                                        .isLoadingList[widget.index]) {
                                      return Align(
                                        alignment: Alignment.topRight,
                                        child: LoadingAnimationWidget
                                            .fourRotatingDots(
                                          color: Colors.indigo,
                                          size: 40,
                                        ),
                                      );
                                    }
                                  }

                                  return Align(
                                    alignment: Alignment.topRight,
                                    child: productController
                                                .getProductAllAPI
                                                .data[widget.index]
                                                .watchListItemId !=
                                            ''
                                        ? InkWell(
                                            onTap: () async {
                                              productController
                                                  .updateButtonState(
                                                      widget.index);
                                              await favoriteController
                                                  .getRemoveFavorite(
                                                      productController
                                                          .getProductAllAPI
                                                          .data[widget.index]
                                                          .watchListItemId);

                                              await productController
                                                  .updateProductAllAPI();

                                              productController
                                                  .updateButtonDisableState(
                                                      widget.index);
                                            },
                                            child: const Icon(
                                              CupertinoIcons.heart_solid,
                                              color: Colors.red,
                                              size: 16,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              productController
                                                  .updateButtonState(
                                                      widget.index);
                                              await favoriteController
                                                  .getAddInFavorite(
                                                      productController
                                                          .getProductAllAPI
                                                          .data[widget.index]
                                                          .id);

                                              await productController
                                                  .updateProductAllAPI();

                                              productController
                                                  .updateButtonDisableState(
                                                      widget.index);
                                            },
                                            child: const Icon(
                                              CupertinoIcons.heart,
                                              size: 16,
                                            ),
                                          ),
                                  );
                                }, listener: (listener, state) {
                                  if (state
                                      is BlocFavoriteRemoveToFavoriteSuccessfullyState) {
                                    Future.delayed(const Duration(seconds: 0),
                                        () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Item will be Remove From Favorite... Please Wait.....!!!!',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    });
                                  } else if (state
                                      is BlocFavoriteAddToFavoriteSuccessfullyState) {
                                    Future.delayed(const Duration(seconds: 0),
                                        () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Item will be Added in Favorite... Please Wait.....!!!!',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    });
                                  }
                                }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height / 100,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: size.width,
                                    child: AutoSizeText(
                                      widget.name,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 30),
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
                            height: size.height / 60,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 14.0, right: 14.0),
                            child: SizedBox(
                              width: size.width,
                              child: AutoSizeText(
                                widget.shortDescription,
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
                              width: size.width,
                              child: AutoSizeText(
                                '\$${widget.price}',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 2,
                            child: productController.getProductAllAPI
                                        .data[widget.index].quantity !=
                                    0
                                ? InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: size.width,
                                      height: size.height / 15,
                                      decoration: BoxDecoration(
                                          color: Colors.pink,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: const Center(
                                          child: Text(
                                        "Added in Cart",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  )
                                : BlocConsumer<BlocCartScreenCubit,
                                        BlocCartScreenState>(
                                    builder: (builder, state) {
                                      if (state is BlocCartLoadingState) {
                                        return LoadingAnimationWidget
                                            .fourRotatingDots(
                                          color: Colors.indigo,
                                          size: 40,
                                        );
                                      }
                                      return InkWell(
                                        onTap: () async {
                                          await cartController.addToCart(
                                              productController.getProductAllAPI
                                                  .data[widget.index].id);
                                          await productController
                                              .productAllAPI();
                                        },
                                        child: Container(
                                          width: size.width,
                                          height: size.height / 15,
                                          decoration: BoxDecoration(
                                              color: Colors.indigo,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: const Center(
                                              child: Text(
                                            "Add to Cart",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      );
                                    },
                                    listener: (listener, state) {}),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              listener: (listener, state) {},
            );
          },
          listener: (listener, state) {},
        );
      },
      listener: (listener, state) {},
    );
  }
}
