import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenBloc.dart';
import '../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenEvent.dart';
import '../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenState.dart';
import '../BlocFavouriteMainScreen/BlocFavouriteMainScreen.dart';
import '../BlocOrderPlaceMainScreen/Bloc/BlocOrderPlaceMainBloc.dart';
import '../BlocOrderPlaceMainScreen/Bloc/BlocOrderPlaceMainEvent.dart';
import '../BlocOrderPlaceMainScreen/Bloc/BlocOrderPlaceMainState.dart';

import '../Bloc_HomePage.dart';
import '../Utils/BlocDrawerWidget.dart';
import '../Utils/BlocFirebaseApiCalling.dart';
import 'Bloc/CartMainScreenBloc.dart';
import 'Bloc/CartMainScreenEvent.dart';
import 'Bloc/CartMainScreenState.dart';
import 'Widget/CartMainScreenListView.dart';

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
    BlocProvider.of<CartMainScreenBloc>(context).add(BlocCartAllDataGetEvent());
    BlocProvider.of<FavouriteScreenBloc>(context)
        .add(BlocFavouriteGetAllItemEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<CartMainScreenBloc, BlocCartScreenState>(
      builder: (builder, state) {
        CartMainScreenBloc cartController =
            BlocProvider.of<CartMainScreenBloc>(context);

        return BlocConsumer<FavouriteScreenBloc, BlocFavoriteScreenState>(
          builder: (builder, state) {
            FavouriteScreenBloc favoriteController =
                BlocProvider.of<FavouriteScreenBloc>(context);

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
                                        const BlocFavouriteMainScreen()));
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
                          child: BlocConsumer<CartMainScreenBloc,
                              BlocCartScreenState>(builder: (builder, state) {
                            if (state is BlocCartLoadingState ||
                                state is BlocOrderPlaceGetLoadingState) {
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
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: CartMainScreenListView(),
                              ),
                            );
                          }, listener: (listener, state) {
                            if (state is BlocOrderPlaceGetSuccessfullyState) {
                              context
                                  .read<CartMainScreenBloc>()
                                  .add(BlocCartAllDataUpdateEvent());
                            }
                          })),
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
                                            BlocConsumer<BlocOrderPlaceMainBloc,
                                                BlocOrderPlaceMainState>(
                                              builder: (builder, state) {
                                                if (state
                                                    is BlocOrderPlaceAddLoadingState) {
                                                  return const CircularProgressIndicator();
                                                }
                                                return TextButton(
                                                  onPressed: () async {
                                                    BlocProvider.of<
                                                                BlocOrderPlaceMainBloc>(
                                                            context)
                                                        .add(BlocPlaceOrderItemEvent(
                                                            cartController
                                                                .blocCartAddItemModelClass
                                                                .data[0]
                                                                .cartId
                                                                .toString(),
                                                            cartController
                                                                .blocCartAddItemModelClass
                                                                .cartTotal
                                                                .toString()));

                                                    // Navigator.of(context).pop();
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
                                                  context
                                                      .read<
                                                          CartMainScreenBloc>()
                                                      .add(
                                                          BlocCartAllDataUpdateEvent());
                                                  Navigator.of(context).pop();
                                                  BlocFirebaseApiCalling
                                                      .sendPushNotification(
                                                          "Online Ordering System",
                                                          "${'You added'} ${cartController.blocCartAddItemModelClass.data.length} ${'Product and Total Price'} ${cartController.blocCartAddItemModelClass.cartTotal.toStringAsFixed(3)}");

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
                                                }
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
}
