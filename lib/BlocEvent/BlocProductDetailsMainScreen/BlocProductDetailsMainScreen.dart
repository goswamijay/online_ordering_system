import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:online_ordering_system/BlocEvent/BlocCartMainScreen/CartMainScreen.dart';

import '../BlocCartMainScreen/Bloc/CartMainScreenBloc.dart';
import '../BlocCartMainScreen/Bloc/CartMainScreenEvent.dart';
import '../BlocCartMainScreen/Bloc/CartMainScreenState.dart';
import '../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenBloc.dart';
import '../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenEvent.dart';
import '../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenState.dart';
import '../BlocProductMainScreen/Bloc/ProductMainScreenBloc.dart';
import '../BlocProductMainScreen/Bloc/ProductMainScreenEvent.dart';
import '../BlocProductMainScreen/Bloc/ProductMainScreenState.dart';

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

    ProductMainScreenBloc productController =
        BlocProvider.of<ProductMainScreenBloc>(context);


    return BlocConsumer<FavouriteScreenBloc, BlocFavoriteScreenState>(
      builder: (controller, state) {
        return BlocConsumer<CartMainScreenBloc, BlocCartScreenState>(
          builder: (controller, state) {
            return BlocConsumer<ProductMainScreenBloc,
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
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) => const BlocCartMainScreen()));
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
                                BlocConsumer<FavouriteScreenBloc,
                                        BlocFavoriteScreenState>(
                                    builder: (builder, state) {

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
                                              context
                                                  .read<ProductMainScreenBloc>()
                                                  .add(ProductUpdateButtonEvent(
                                                      true, widget.index));
                                              context
                                                  .read<FavouriteScreenBloc>()
                                                  .add(BlocFavouriteRemoveProductEvent(
                                                      productController
                                                          .getProductAllAPI
                                                          .data[widget.index]
                                                          .watchListItemId));
                                            },
                                            child: const Icon(
                                              CupertinoIcons.heart_solid,
                                              color: Colors.red,
                                              size: 16,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              context
                                                  .read<ProductMainScreenBloc>()
                                                  .add(ProductUpdateButtonEvent(
                                                      true, widget.index));
                                              context
                                                  .read<FavouriteScreenBloc>()
                                                  .add(
                                                      BlocFavouriteAddProductEvent(
                                                          productController
                                                              .getProductAllAPI
                                                              .data[
                                                                  widget.index]
                                                              .id));
                                            },
                                            child: const Icon(
                                              CupertinoIcons.heart,
                                              size: 16,
                                            ),
                                          ),
                                  );
                                }, listener: (listener, state) {
                                  if (state
                                      is BlocFavoriteAddToFavoriteSuccessfullyState) {
                                    context
                                        .read<ProductMainScreenBloc>()
                                        .add(ProductAllItemUpdateEvent());

                                    context.read<ProductMainScreenBloc>().add(
                                        ProductUpdateButton2Event(
                                            false, widget.index));
                                  } else if (state
                                      is BlocFavoriteRemoveToFavoriteSuccessfullyState) {
                                    context
                                        .read<ProductMainScreenBloc>()
                                        .add(ProductAllItemUpdateEvent());

                                    context.read<ProductMainScreenBloc>().add(
                                        ProductUpdateButton2Event(
                                            false, widget.index));
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
                                : BlocConsumer<CartMainScreenBloc,
                                        BlocCartScreenState>(
                                    builder: (builder, state) {
                                    if (state is BlocCartItemLoadingState) {
                                      return LoadingAnimationWidget
                                          .fourRotatingDots(
                                        color: Colors.indigo,
                                        size: 40,
                                      );
                                    }
                                    return InkWell(
                                      onTap: () async {
                                        context
                                            .read<ProductMainScreenBloc>()
                                            .add(ProductUpdateButtonEvent(
                                                true, widget.index));
                                        context.read<CartMainScreenBloc>().add(
                                            BlocCartAddToCartEvent(
                                                productController
                                                    .getProductAllAPI
                                                    .data[widget.index]
                                                    .id));
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
                                  }, listener: (listener, state) {
                                    if (state
                                        is BlocCartAddToCartSuccessfullyState) {
                                      context
                                          .read<ProductMainScreenBloc>()
                                          .add(ProductAllItemUpdateEvent());

                                      context.read<ProductMainScreenBloc>().add(
                                          ProductUpdateButton2Event(
                                              false, widget.index));
                                    }
                                  }),
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
