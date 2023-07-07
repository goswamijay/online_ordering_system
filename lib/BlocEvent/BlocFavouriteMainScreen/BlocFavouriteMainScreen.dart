import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../BlocCartMainScreen/CartMainScreen.dart';
import '../BlocProductMainScreen/Bloc/ProductMainScreenBloc.dart';
import '../BlocProductMainScreen/Bloc/ProductMainScreenState.dart';
import '../Bloc_HomePage.dart';
import '../Utils/BlocDrawerWidget.dart';
import 'Bloc/BlocFavouriteScreenBloc.dart';
import 'Bloc/BlocFavouriteScreenEvent.dart';
import 'Bloc/BlocFavouriteScreenState.dart';
import 'Widget/BlocFavouriteScreenListView.dart';

class BlocFavouriteMainScreen extends StatelessWidget {
  const BlocFavouriteMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavouriteScreenBloc>(context)
        .add(BlocFavouriteGetAllItemEvent());
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
                      MaterialPageRoute(builder: (_) => const BlocHomePage()),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BlocCartMainScreen()));
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
                          BlocBuilder<ProductMainScreenBloc,
                              BlocProductMainScreenState>(
                            builder: (BuildContext context, state) {
                              ProductMainScreenBloc productController =
                                  BlocProvider.of<ProductMainScreenBloc>(
                                      context);
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
                                      style:
                                          const TextStyle(color: Colors.white),
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
          body: BlocBuilder<FavouriteScreenBloc, BlocFavoriteScreenState>(
              builder: (builder, state) {
            if (state is BlocFavoriteLoadingState) {
              return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.indigo,
                size: 40,
              ));
            }
            return const Padding(
              padding: EdgeInsets.all(4.0),
              child: BlocFavouriteScreenListView(),
            );
          }),
        ));
  }
}
