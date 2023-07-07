import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocCartMainScreen/Bloc/CartMainScreenBloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocCartMainScreen/Bloc/CartMainScreenState.dart';
import '../../BlocLogin/LoginPageUI.dart';
import '../../BlocProductMainScreen/Bloc/ProductMainScreenBloc.dart';
import '../../BlocProductMainScreen/Bloc/ProductMainScreenState.dart';
import '../Bloc/BlocFavouriteScreenBloc.dart';
import '../Bloc/BlocFavouriteScreenEvent.dart';
import '../Bloc/BlocFavouriteScreenState.dart';

class BlocFavouriteScreenListView extends StatelessWidget {
  const BlocFavouriteScreenListView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FavouriteScreenBloc favoriteController =
        BlocProvider.of<FavouriteScreenBloc>(context);

    return BlocConsumer<CartMainScreenBloc, BlocCartScreenState>(
        builder: (builder, state) {
          return BlocConsumer<ProductMainScreenBloc,
                  BlocProductMainScreenState>(
              builder: (builder, state) {
                return BlocConsumer<FavouriteScreenBloc,
                    BlocFavoriteScreenState>(builder: (builder, state) {
                  return favoriteController
                          .blocFavoriteAddItemModelClass.data.isEmpty
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: ListView.builder(
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
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: favoriteController
                                                                .blocFavoriteAddItemModelClass
                                                                .data[index]
                                                                .id !=
                                                            ''
                                                        ? InkWell(
                                                            onTap: () {
                                                              favoriteController.add(
                                                                  BlocFavouriteRemoveProductEvent(
                                                                      favoriteController
                                                                          .blocFavoriteAddItemModelClass
                                                                          .data[
                                                                              index]
                                                                          .id));
                                                              favoriteController
                                                                  .add(
                                                                      BlocFavouriteUpdateAllItemEvent());
                                                            },
                                                            child: const Icon(
                                                              CupertinoIcons
                                                                  .heart_solid,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                          )
                                                        : InkWell(
                                                            onTap: () {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                    'Product Added To Favorite!',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .indigo,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                ),
                                                              );
                                                            },
                                                            child: const Icon(
                                                              CupertinoIcons
                                                                  .heart,
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
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 30),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height / 90,
                                                  ),
                                                  SizedBox(
                                                    width: size.width,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        '\$${favoriteController.blocFavoriteAddItemModelClass.data[index].productDetails.price}',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                          fontWeight:
                                                              FontWeight.w300,
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
                                                                      .data[
                                                                          index]
                                                                      .cartId !=
                                                                  ''
                                                              ? InkWell(
                                                                  onTap: () {},
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
                                                                            BorderRadius.circular(5.0)),
                                                                    child: const Center(
                                                                        child: Text(
                                                                      'Added in Cart',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {},
                                                                  child:
                                                                      Container(
                                                                    width: size
                                                                        .width,
                                                                    height:
                                                                        size.height /
                                                                            20,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .indigo,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.0)),
                                                                    child: const Center(
                                                                        child: Text(
                                                                      'Add to Cart',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                              }),
                        );
                }, listener: (listener, state) {
                  if (state is BlocFavoriteJWTNotFoundState) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BlocLoginScreen()),
                      (route) => false,
                    );
                  }
                });
              },
              listener: (listener, state) {});
        },
        listener: (listener, state) {});
  }
}
