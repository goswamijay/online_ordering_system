import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:online_ordering_system/Bloc/BlocFavoriteMainScreen/BlocFavoriteMainScreen.dart';
import 'package:online_ordering_system/Bloc/BlocOrderPlaceMainScreen/BlocOrderPlaceScreenCubit.dart';
import 'package:online_ordering_system/Bloc/BlocOrderPlaceMainScreen/BlocOrderPlaceScreenState.dart';
import 'package:online_ordering_system/Bloc/Utils/BlocDrawer.dart';

import '../BlocFavoriteMainScreen/BlocFavoriteScreenCubit.dart';
import '../BlocHomePage.dart';
import '../BlocLoginScreen/BlocLoginScreen.dart';

class BlocOrderPlaceMainScreen extends StatefulWidget {
  const BlocOrderPlaceMainScreen({super.key});

  @override
  State<BlocOrderPlaceMainScreen> createState() =>
      _BlocOrderPlaceMainScreenState();
}

class _BlocOrderPlaceMainScreenState extends State<BlocOrderPlaceMainScreen> {
  @override
  Widget build(BuildContext context) {
    BlocOrderPlaceScreenCubit placeOrderController =
        BlocProvider.of<BlocOrderPlaceScreenCubit>(context);
    placeOrderController.placeOrderAllDataAPI();
    BlocFavoriteScreenCubit favoriteController =
        BlocProvider.of<BlocFavoriteScreenCubit>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BlocHomePage()),
          (route) => route.isFirst,
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
                    MaterialPageRoute(builder: (_) => const BlocHomePage()),
                    (route) => route.isFirst,
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
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
                child: Text(
              "Order Placed Items",
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const BlocFavoriteMainScreen()));
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
                                shape: BoxShape.circle, color: Colors.red[900]),
                            width: 34 / 2,
                            height: 34 / 2,
                            child: Text(
                              favoriteController
                                  .blocFavoriteAddItemModelClass.data.length
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
        backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<BlocOrderPlaceScreenCubit,
                  BlocOrderPlaceScreenState>(
              builder: (builder, state) {
                if (state is BlocOrderPlaceGetLoadingState) {
                  return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.indigo,
                    size: 40,
                  ));
                }
                return fullList1(context);
              },
              listener: (listener, state) {}),
        ),
      ),
    );
  }

  Widget fullList1(BuildContext context) {
    BlocOrderPlaceScreenCubit confirmController =
        BlocProvider.of<BlocOrderPlaceScreenCubit>(context);
    Size size = MediaQuery.of(context).size;

    return confirmController.placeOrderModelClass.data.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/oops.png"),
                const Text(
                  "No any items purchase....!",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          )
        : BlocConsumer<BlocOrderPlaceScreenCubit, BlocOrderPlaceScreenState>(
            builder: (builder, state) {
            return ListView.builder(
                itemCount: confirmController.placeOrderModelClass.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Image(
                                image: NetworkImage(confirmController
                                    .placeOrderModelClass.data[index].imageUrl),
                                // fit: BoxFit.cover,
                                width: size.width / 2,
                                height: size.height / 5,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: AutoSizeText(
                                          // "Order Place Date:- ${DateTime.parse("2023-03-10")}",
                                          "${'Order Place Date'}:- ${confirmController.placeOrderModelClass.data[index].updatedAt}",
                                          textAlign: TextAlign.end,
                                          maxLines: 2,
                                          style: const TextStyle(fontSize: 12),
                                        )),
                                    SizedBox(
                                      height: size.height / 120,
                                    ),
                                    SizedBox(
                                      width: size.width,
                                      child: AutoSizeText(
                                        confirmController.placeOrderModelClass
                                            .data[index].title,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 30),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height / 80,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            width: size.width,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                '\$${confirmController.placeOrderModelClass.data[index].price}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: size.width,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: AutoSizeText(
                                                '${'Total Items added'}:-${confirmController.placeOrderModelClass.data[index].quantity}',
                                                style: const TextStyle(
                                                    fontSize: 18),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height / 90,
                                    ),
                                    SizedBox(
                                      width: size.width,
                                      child: AutoSizeText(
                                        confirmController.placeOrderModelClass
                                            .data[index].description,
                                        maxLines: 3,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 25),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height / 90,
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
          }, listener: (listener, state) {
            if (state is BlocOrderPlaceJWTTokenNotFoundState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const BlocLoginScreen()),
                (route) => false,
              );
            }
          });
  }
}
