import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:online_ordering_system/BlocCubit/BlocCartMainScreen/BlocCartScreenCubit.dart';
import 'package:online_ordering_system/BlocCubit/BlocCartMainScreen/BlocCartScreenState.dart';
import 'package:online_ordering_system/BlocCubit/BlocFavoriteMainScreen/BlocFavoriteMainScreen.dart';
import 'package:online_ordering_system/BlocCubit/BlocFavoriteMainScreen/BlocFavoriteScreenCubit.dart';
import 'package:online_ordering_system/BlocCubit/BlocFavoriteMainScreen/BlocFavoriteScreenState.dart';
import 'package:online_ordering_system/BlocCubit/BlocHomePage.dart';
import 'package:online_ordering_system/BlocCubit/BlocOrderPlaceMainScreen/BlocOrderPlaceScreenState.dart';
import 'package:online_ordering_system/BlocCubit/BlocProductMainScreen/BlocProductMainScreenCubit.dart';
import 'package:online_ordering_system/BlocCubit/BlocProductMainScreen/BlocProductMainScreenState.dart';

import '../BlocFirebase/BlocFirebaseApiCalling.dart';
import '../BlocLoginScreen/BlocLoginScreen.dart';
import '../BlocOrderPlaceMainScreen/BlocOrderPlaceScreenCubit.dart';
import '../Utils/BlocDrawer.dart';

class BlocCartMainScreen extends StatefulWidget {
  const BlocCartMainScreen({super.key});

  @override
  State<BlocCartMainScreen> createState() => _BlocCartMainScreenState();
}

class _BlocCartMainScreenState extends State<BlocCartMainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocCartScreenCubit cartController =
        BlocProvider.of<BlocCartScreenCubit>(context);
    cartController.getCartAllDataAPI();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocOrderPlaceScreenCubit orderPlaceController =
        BlocProvider.of<BlocOrderPlaceScreenCubit>(context);

    return BlocConsumer<BlocCartScreenCubit, BlocCartScreenState>(
      builder: (builder, state) {
        BlocCartScreenCubit cartController =
            BlocProvider.of<BlocCartScreenCubit>(context);

        return BlocConsumer<BlocFavoriteScreenCubit, BlocFavoriteScreenState>(
          builder: (builder, state) {
            BlocFavoriteScreenCubit favoriteController =
                BlocProvider.of<BlocFavoriteScreenCubit>(context);

            return WillPopScope(
                onWillPop: () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const BlocHomePage()),
                    (route) => false,
                  );
                  return false;
                },
                child: Scaffold(
                  drawer: const BlocDrawerWidget(),
                  appBar: AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const BlocHomePage()),
                              (route) => false,
                            );
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
                        'My Cart',
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const BlocFavoriteMainScreen()));
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
                                            .blocFavoriteAddItemModelClass
                                            .data
                                            .length
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
                        child: BlocConsumer<BlocCartScreenCubit,
                                BlocCartScreenState>(
                            builder: (builder, state) {
                              if (state is BlocCartLoadingState) {
                                return Center(
                                    child:
                                        LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.indigo,
                                  size: 40,
                                ));
                              }
                              return Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(246, 244, 244, 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(16.0),
                                        topLeft: Radius.circular(16.0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: fullList1(context),
                                ),
                              );
                            },
                            listener: (listener, state) {}),
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
                                        "${'Total Item'} (${cartController.blocCartAddItemModelClass.data.length}) :-",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        " \$${cartController.blocCartAddItemModelClass.cartTotal.toStringAsFixed(3)}",
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
                                        "${'Total Price'} :-",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        " \$${cartController.blocCartAddItemModelClass.cartTotal.toStringAsFixed(3)}",
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
                              cartController
                                      .blocCartAddItemModelClass.data.isNotEmpty
                                  ? showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Confirm to Place Order'),
                                          content: Text(
                                            "${'You added'} ${cartController.blocCartAddItemModelClass.data.length} ${'Product and Total Price'} ${cartController.blocCartAddItemModelClass.cartTotal.toStringAsFixed(3)}",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Close the dialog
                                              },
                                            ),
                                            BlocConsumer<
                                                BlocOrderPlaceScreenCubit,
                                                BlocOrderPlaceScreenState>(
                                              builder: (builder, state) {
                                                if (state
                                                    is BlocOrderPlaceAddLoadingState) {
                                                  return const CircularProgressIndicator();
                                                }
                                                return TextButton(
                                                  onPressed: () async {
                                                    await BlocProvider.of<
                                                                BlocOrderPlaceScreenCubit>(
                                                            context)
                                                        .getPlaceOrder(
                                                            cartController
                                                                .blocCartAddItemModelClass
                                                                .data[0]
                                                                .cartId
                                                                .toString(),
                                                            cartController
                                                                .blocCartAddItemModelClass
                                                                .cartTotal
                                                                .toString());

                                                    BlocFirebaseApiCalling
                                                        .sendPushNotification(
                                                            "Online Ordering System",
                                                            "${'You added'} ${cartController.blocCartAddItemModelClass.data.length} ${'Product and Total Price'} ${cartController.blocCartAddItemModelClass.cartTotal.toStringAsFixed(3)}");

                                                    Navigator.of(context).pop();
                                                    await cartController
                                                        .getCartAllDataAPI();
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.indigo),
                                                  ),
                                                  child: const Text(
                                                    'Confirm',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                              },
                                              listener: (listener, state) {
                                                if (state
                                                    is BlocOrderPlaceAddSuccessfullyState) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Lottie.asset(
                                                          'assets/Animation/placeholder.json',
                                                          height: 100,
                                                          width: 100,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } else if (state
                                                    is BlocOrderPlaceAddLoadingState) {}
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  : showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'No Items added in cart ....!'),
                                          content: const Text(
                                              'Please add item in cart'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Close the dialog
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.indigo),
                                              ),
                                              child: const Text(
                                                'Okay',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                            },
                            child: Container(
                              height: size.height / 15,
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Center(
                                  child: Text(
                                'Place Order',
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
                ));
          },
          listener: (listener, state) {},
        );
      },
      listener: (listener, state) {},
    );
  }

  Widget fullList1(BuildContext context) {
    final cartController = BlocProvider.of<BlocCartScreenCubit>(context);
    final favoriteController =
        BlocProvider.of<BlocFavoriteScreenCubit>(context);
    final productController =
        BlocProvider.of<BlocProductMainScreenCubit>(context);
    Size size = MediaQuery.of(context).size;

    return cartController.blocCartAddItemModelClass.data.isEmpty
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
                  height: size.height / 2,
                  width: size.width / 2,
                ),
                const Center(
                  child: Text(
                    'No Items added in cart ....!',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          )
        : BlocConsumer<BlocCartScreenCubit, BlocCartScreenState>(
            builder: (builder, state) {
            if (state is BlocCartLoadingState) {
              return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.indigo,
                size: 40,
              ));
            }
            return BlocConsumer<BlocProductMainScreenCubit,
                    BlocProductMainScreenState>(
                builder: (builder, state) {
                  return BlocConsumer<BlocFavoriteScreenCubit,
                          BlocFavoriteScreenState>(
                      builder: (builder, state) {
                        return ListView.builder(
                            itemCount: cartController
                                .blocCartAddItemModelClass.data.length,
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
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Image(
                                                  image: NetworkImage(cartController
                                                      .blocCartAddItemModelClass
                                                      .data[index]
                                                      .productDetails!
                                                      .imageUrl),
                                                  width: size.width / 2,
                                                  height: size.height / 5,
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
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: productController
                                                                  .getProductAllAPI
                                                                  .data[index]
                                                                  .watchListItemId !=
                                                              ''
                                                          ? InkWell(
                                                              onTap: () async {
                                                                await favoriteController.getRemoveFavorite(
                                                                    productController
                                                                        .getProductAllAPI
                                                                        .data[
                                                                            index]
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
                                                                      content:
                                                                          Text(
                                                                        'Product Remove From Favorite!',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .indigo,
                                                                      duration: Duration(
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
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap: () async {
                                                                await favoriteController.getAddInFavorite(
                                                                    cartController
                                                                        .blocCartAddItemModelClass
                                                                        .data[
                                                                            index]
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
                                                                      content:
                                                                          Text(
                                                                        'Product Added To Favorite!',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .indigo,
                                                                      duration: Duration(
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
                                                                    .heart,
                                                                size: 16,
                                                              ),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: size.width,
                                                  child: AutoSizeText(
                                                    cartController
                                                        .blocCartAddItemModelClass
                                                        .data[index]
                                                        .productDetails!
                                                        .title,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height / 70,
                                                ),
                                                SizedBox(
                                                  width: size.width,
                                                  child: AutoSizeText(
                                                    cartController
                                                        .blocCartAddItemModelClass
                                                        .data[index]
                                                        .productDetails!
                                                        .description,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height / 70,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: size.width,
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: AutoSizeText(
                                                            '\$${cartController.blocCartAddItemModelClass.data[index].productDetails!.price}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 25),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    BlocConsumer<
                                                            BlocCartScreenCubit,
                                                            BlocCartScreenState>(
                                                        listener: (listener,
                                                            state) {},
                                                        builder:
                                                            (builder, state) {
                                                          if (state
                                                              is BlocCartItemRemoveLoadingState) {
                                                            if (cartController
                                                                    .isLoadingList[
                                                                index]) {
                                                              return Expanded(
                                                                child: LoadingAnimationWidget
                                                                    .fourRotatingDots(
                                                                  color: Colors
                                                                      .indigo,
                                                                  size: 40,
                                                                ),
                                                              );
                                                            }
                                                          }

                                                          return Expanded(
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  cartController
                                                                      .updateButtonState(
                                                                          index);
                                                                  await cartController.removeProductFromCart(
                                                                      cartController
                                                                          .blocCartAddItemModelClass
                                                                          .data[
                                                                              index]
                                                                          .id);

                                                                  cartController
                                                                      .getCartAllDataAPI();
                                                                  cartController
                                                                      .updateButtonDisableState(
                                                                          index);
                                                                },
                                                                icon: const Icon(
                                                                    CupertinoIcons
                                                                        .delete)),
                                                          );
                                                        }),
                                                    BlocConsumer<
                                                            BlocCartScreenCubit,
                                                            BlocCartScreenState>(
                                                        listener: (listener,
                                                            state) {},
                                                        builder:
                                                            (builder, state) {
                                                          if (state
                                                              is BlocCartItemLoadingState) {
                                                            if (cartController
                                                                    .isLoadingList[
                                                                index]) {
                                                              return Expanded(
                                                                child: LoadingAnimationWidget
                                                                    .fourRotatingDots(
                                                                  color: Colors
                                                                      .indigo,
                                                                  size: 40,
                                                                ),
                                                              );
                                                            }
                                                          }

                                                          return Expanded(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    cartController
                                                                        .updateButtonState(
                                                                            index);
                                                                    await cartController.decreaseProductQuantity(cartController
                                                                        .blocCartAddItemModelClass
                                                                        .data[
                                                                            index]
                                                                        .id);

                                                                    await cartController
                                                                        .getCartAllDataAPI();
                                                                    cartController
                                                                        .updateButtonDisableState(
                                                                            index);
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors.grey[
                                                                            200],
                                                                    radius: 14,
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
                                                                  cartController
                                                                      .blocCartAddItemModelClass
                                                                      .data[
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    cartController
                                                                        .updateButtonState(
                                                                            index);
                                                                    await cartController.increaseProductQuantity(cartController
                                                                        .blocCartAddItemModelClass
                                                                        .data[
                                                                            index]
                                                                        .id);

                                                                    await cartController
                                                                        .getCartAllDataAPI();
                                                                    cartController
                                                                        .updateButtonDisableState(
                                                                            index);
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors.grey[
                                                                            200],
                                                                    radius: 14,
                                                                    child: const Center(
                                                                        child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        }),
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
                            });
                      },
                      listener: (listener, state) {});
                },
                listener: (listener, state) {});
          }, listener: (listener, state) {
            if (state is BlocCartJWTNotFoundState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const BlocLoginScreen()),
                (route) => false,
              );
            }
          });
  }
}
