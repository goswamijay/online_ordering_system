import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:online_ordering_system/BlocEvent/BlocProductDetailsMainScreen/BlocProductDetailsMainScreen.dart';
import 'package:online_ordering_system/BlocEvent/ModelClassBlocEvent/BlocProductMainScreenModel.dart';
import 'package:online_ordering_system/BlocEvent/Utils/repo.dart';
import '../../BlocCartMainScreen/Bloc/CartMainScreenBloc.dart';
import '../../BlocCartMainScreen/Bloc/CartMainScreenEvent.dart';
import '../../BlocCartMainScreen/Bloc/CartMainScreenState.dart';
import '../../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenBloc.dart';
import '../../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenEvent.dart';
import '../../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenState.dart';
import '../../BlocLogin/LoginPageUI.dart';
import '../Bloc/ProductMainScreenBloc.dart';
import '../Bloc/ProductMainScreenEvent.dart';
import '../Bloc/ProductMainScreenState.dart';

class ProductMainScreenItems extends StatefulWidget {
  const ProductMainScreenItems({super.key});

  @override
  State<ProductMainScreenItems> createState() => _ProductMainScreenItemsState();
}

class _ProductMainScreenItemsState extends State<ProductMainScreenItems> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          ProductMainScreenBloc()..add(ProductAllItemShowingEvent()),
      child: BlocConsumer<ProductMainScreenBloc, BlocProductMainScreenState>(
          listenWhen: (previousState, state) {
        return previousState is BlocProductMainScreenUpdateState;
      }, builder: (builder, state) {
        BlocProductAllAPI productController = Repo.getProductAllAPI;
        if (state is BlocProductMainLoadingScreenState) {
          return LoadingAnimationWidget.fourRotatingDots(
            color: Colors.indigo,
            size: 40,
          );
        } else if (state is BlocProductMainScreenUpdateState) {
          productController = state.getProductAllAPI;
        }

        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: productController.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProductDetailsScreen(
                            price: Repo.getProductAllAPI.data[index].price,
                            name: Repo.getProductAllAPI.data[index].title,
                            imageURL:
                                Repo.getProductAllAPI.data[index].imageUrl,
                            shortDescription:
                                Repo.getProductAllAPI.data[index].description,
                            index: index,
                          )));
                },
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: productController
                                      .data[index].imageUrl.isNotEmpty
                                  ? Image(
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                            child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                                      .toInt()
                                              : null,
                                        ));
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                      image: NetworkImage(productController
                                          .data[index].imageUrl),
                                      width: size.width / 2,
                                      height: size.height / 5,
                                    )
                                  : const CircularProgressIndicator()),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 5.0, bottom: 8.0, top: 8.0),
                              child: Column(
                                children: [
                                  BlocConsumer<FavouriteScreenBloc,
                                          BlocFavoriteScreenState>(
                                      builder: (builder, state) {
                                    ProductMainScreenBloc productController1 =
                                        BlocProvider.of<ProductMainScreenBloc>(
                                            context);
                                    if (state is BlocFavoriteLoadingState) {
                                      if (productController1
                                          .isLoadingList[index]) {
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
                                      child: productController.data[index]
                                                  .watchListItemId !=
                                              ''
                                          ? InkWell(
                                        key: Key(
                                            'Home_Page_to_remove_favourite_button:-$index'),
                                              onTap: () async {
                                                context
                                                    .read<
                                                        ProductMainScreenBloc>()
                                                    .add(
                                                        ProductUpdateButtonEvent(
                                                            true, index));
                                                context
                                                    .read<FavouriteScreenBloc>()
                                                    .add(BlocFavouriteRemoveProductEvent(
                                                        productController
                                                            .data[index]
                                                            .watchListItemId));
                                              },
                                              child: const Icon(
                                                CupertinoIcons.heart_solid,
                                                color: Colors.red,
                                                size: 16,
                                              ),
                                            )
                                          : InkWell(
                                              key: Key(
                                                  'Home_Page_to_add_favourite_button:-$index'),
                                              onTap: () async {
                                                context
                                                    .read<
                                                        ProductMainScreenBloc>()
                                                    .add(
                                                        ProductUpdateButtonEvent(
                                                            true, index));
                                                context
                                                    .read<FavouriteScreenBloc>()
                                                    .add(
                                                        BlocFavouriteAddProductEvent(
                                                            productController
                                                                .data[index]
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
                                              false, index));
                                    } else if (state
                                        is BlocFavoriteRemoveToFavoriteSuccessfullyState) {
                                      context
                                          .read<ProductMainScreenBloc>()
                                          .add(ProductAllItemUpdateEvent());

                                      context.read<ProductMainScreenBloc>().add(
                                          ProductUpdateButton2Event(
                                              false, index));
                                    }
                                  }),
                                  SizedBox(
                                    width: size.width,
                                    child: AutoSizeText(
                                      productController.data[index].title,
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
                                        '\$${productController.data[index].price}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 60,
                                  ),
                                  SizedBox(
                                    width: size.width,
                                    child: AutoSizeText(
                                      productController.data[index].description,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 30),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 60,
                                  ),
                                  BlocConsumer<CartMainScreenBloc,
                                      BlocCartScreenState>(
                                    builder: (builder, state) {
                                      if (state is BlocCartItemLoadingState) {
                                        if (BlocProvider.of<
                                                ProductMainScreenBloc>(context)
                                            .isLoadingList[index]) {
                                          return LoadingAnimationWidget
                                              .fourRotatingDots(
                                            color: Colors.indigo,
                                            size: 40,
                                          );
                                        }
                                      }

                                      return Row(
                                        children: [
                                          Expanded(
                                              child:
                                                  productController.data[index]
                                                              .quantity !=
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Expanded(
                                                              child: InkWell(
                                                                child:
                                                                    Container(
                                                                  width: size
                                                                      .width,
                                                                  height:
                                                                      size.height /
                                                                          20,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .pink,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0)),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'Added in Cart',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  InkWell(
                                                                    key: Key(
                                                                        'Home_Page_to_decreases_cart_item_button:-$index'),
                                                                    onTap:
                                                                        () async {
                                                                      context
                                                                          .read<
                                                                              ProductMainScreenBloc>()
                                                                          .add(ProductUpdateButtonEvent(
                                                                              true,
                                                                              index));
                                                                      context
                                                                          .read<
                                                                              CartMainScreenBloc>()
                                                                          .add(BlocCartDecreaseProductQuantityEvent(productController
                                                                              .data[index]
                                                                              .cartItemId));
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[200],
                                                                      // Colors.pink[500],
                                                                      radius:
                                                                          14,
                                                                      child: const Center(
                                                                          child: Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    productController
                                                                        .data[
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  InkWell(
                                                                    key: Key(
                                                                        'Home_Page_to_increases_cart_item_button:-$index'),
                                                                    onTap:
                                                                        () async {
                                                                      context
                                                                          .read<
                                                                              ProductMainScreenBloc>()
                                                                          .add(ProductUpdateButtonEvent(
                                                                              true,
                                                                              index));
                                                                      context
                                                                          .read<
                                                                              CartMainScreenBloc>()
                                                                          .add(BlocCartIncreaseProductQuantityEvent(productController
                                                                              .data[index]
                                                                              .cartItemId));
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[200],
                                                                      radius:
                                                                          14,
                                                                      child: const Center(
                                                                          child: Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : InkWell(
                                                          key: Key(
                                                              'Home_Page_add_to_cart_button:-$index'),
                                                          onTap: () async {
                                                            context
                                                                .read<
                                                                    ProductMainScreenBloc>()
                                                                .add(
                                                                    ProductUpdateButtonEvent(
                                                                        true,
                                                                        index));
                                                            context
                                                                .read<
                                                                    CartMainScreenBloc>()
                                                                .add(BlocCartAddToCartEvent(
                                                                    productController
                                                                        .data[
                                                                            index]
                                                                        .id));
                                                          },
                                                          child: Container(
                                                            width: size.width,
                                                            height:
                                                                size.height /
                                                                    20,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .indigo,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0)),
                                                            child: const Center(
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
                                                        )),
                                        ],
                                      );
                                    },
                                    listener: (listener, state) {
                                      if (state
                                          is BlocCartAddToCartSuccessfullyState) {
                                        context
                                            .read<ProductMainScreenBloc>()
                                            .add(ProductAllItemUpdateEvent());

                                        context
                                            .read<ProductMainScreenBloc>()
                                            .add(ProductUpdateButton2Event(
                                                false, index));
                                      } else if (state
                                          is BlocCartDecreaseSuccessfullyState) {
                                        context
                                            .read<ProductMainScreenBloc>()
                                            .add(ProductAllItemUpdateEvent());

                                        context
                                            .read<ProductMainScreenBloc>()
                                            .add(ProductUpdateButton2Event(
                                                false, index));
                                      } else if (state
                                          is BlocCartIncreaseSuccessfullyState) {
                                        context
                                            .read<ProductMainScreenBloc>()
                                            .add(ProductAllItemUpdateEvent());

                                        context
                                            .read<ProductMainScreenBloc>()
                                            .add(ProductUpdateButton2Event(
                                                false, index));
                                      }
                                    },
                                  ),
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
      }, listener: (builder, state) {
        if (state is BlocProductMainJWTNotFoundProductScreenState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const BlocLoginScreen()),
            (route) => false,
          );
        }
      }),
    );
  }
}
