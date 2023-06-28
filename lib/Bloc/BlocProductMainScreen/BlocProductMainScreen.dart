import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:online_ordering_system/Bloc/BlocCartMainScreen/BlocCartMainScreen.dart';
import 'package:online_ordering_system/Bloc/BlocCartMainScreen/BlocCartScreenState.dart';
import 'package:online_ordering_system/Bloc/BlocFavoriteMainScreen/BlocFavoriteScreenState.dart';
import 'package:online_ordering_system/Bloc/BlocProductMainScreen/BlocProductMainScreenCubit.dart';
import 'package:online_ordering_system/Bloc/BlocProductMainScreen/BlocProductMainScreenState.dart';
import 'package:online_ordering_system/Bloc/Utils/BlocDrawer.dart';

import '../BlocCartMainScreen/BlocCartScreenCubit.dart';
import '../BlocFavoriteMainScreen/BlocFavoriteScreenCubit.dart';
import '../BlocLoginScreen/BlocLoginScreen.dart';
import '../BlocProductDetailsScreen/BlocProductDetailsScreen.dart';

class BlocProductMainScreen extends StatefulWidget {
  const BlocProductMainScreen({super.key});

  @override
  State<BlocProductMainScreen> createState() => _BlocProductMainScreenState();
}

class _BlocProductMainScreenState extends State<BlocProductMainScreen>
    with TickerProviderStateMixin {
  TextEditingController search = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  List<dynamic> searchItems = [];
  int currentIndex = 0;

  BlocProductMainScreenCubit? productController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchItemChange();
  }

  searchItemChange() async {
    productController = BlocProvider.of<BlocProductMainScreenCubit>(context);
    await productController!.productAllAPI();
    searchItems = productController!.getProductAllAPI.data;
    productController!.searchUnButtonPress();
    searchController.clear();
  }

  void onSearchTextChanged(String text) {
    List<dynamic> result = [];
    if (text.isEmpty) {
      result = productController!.getProductAllAPI.data;
    } else {
      result = productController!.getProductAllAPI.data
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }

    if (result.isEmpty) {
      productController!.searchButtonPress();

      // buttonController.listIsEmpty.value = true;
    } else {
      productController!.searchUnButtonPress();

      // buttonController.listIsEmpty.value = false;
    }
    searchItems = result;
  }

  final List<String> imgList = [
    'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
    'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
    'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
  ];
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: () async {
            final now = DateTime.now();
            if (_lastPressedAt == null ||
                now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
              _lastPressedAt = now;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Row(
                  children: [
                    Text(
                      'Press back again to exit',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Icon(CupertinoIcons.back),
                  ],
                ),
                backgroundColor: Colors.white,
              ));

              return false;
            }
            return true;
          },
          child: Scaffold(
            key: _scaffoldKey,
            drawer: const BlocDrawerWidget(),
            // backgroundColor: const Color.fromRGBO(246, 244, 244, 1),
            appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: Colors.transparent,
                elevation: 0,
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
                ]),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            BlocBuilder<BlocProductMainScreenCubit,
                                    BlocProductMainScreenState>(
                                builder: (builder, state) {
                              BlocProductMainScreenCubit productController =
                                  BlocProvider.of<BlocProductMainScreenCubit>(
                                      context);
                              return Row(
                                children: [
                                  Expanded(
                                    child: CupertinoSearchTextField(
                                      backgroundColor: Colors.white,
                                      itemSize: size.height / 33,
                                      controller: searchController,
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          productController
                                              .searchUnButtonPress();
                                          setState(() {});
                                        } else {
                                          onSearchTextChanged(value);
                                          productController.searchButtonPress();
                                          setState(() {});
                                        }
                                      },
                                      onSuffixTap: () {
                                        productController.searchUnButtonPress();
                                        searchController.clear();
                                        setState(() {});
                                      },
                                      onSubmitted: (value) {},
                                      autocorrect: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 80,
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      // buildDialog(context),
                                    },
                                    child: Container(
                                      height: size.height / 25,
                                      width: size.width / 16,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.black),
                                      child: const Icon(
                                        Icons.translate_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                            SizedBox(
                              height: size.height / 50,
                            ),
                            BlocBuilder<BlocProductMainScreenCubit,
                                BlocProductMainScreenState>(
                              builder: (BuildContext context, state) {
                                BlocProductMainScreenCubit productController =
                                    BlocProvider.of<BlocProductMainScreenCubit>(
                                        context);
                                return CarouselSlider(
                                  options: CarouselOptions(
                                      aspectRatio: 2.0,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      autoPlay: true,
                                      height: 180,
                                      onPageChanged: (index, reason) {
                                        productController.updateIndex(index);
                                      }),
                                  items: imgList
                                      .map((item) => Center(
                                          child: Image.network(item,
                                              fit: BoxFit.cover,
                                              width: size.width / 1.1)))
                                      .toList(),
                                );
                              },
                            ),
                            BlocBuilder<BlocProductMainScreenCubit,
                                    BlocProductMainScreenState>(
                                builder: (listener, state) {
                              BlocProductMainScreenCubit productController =
                                  BlocProvider.of<BlocProductMainScreenCubit>(
                                      context);
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: imgList.map((e) {
                                    int index = imgList.indexOf(e);
                                    return Container(
                                      width: 8,
                                      height: 8,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: productController.photoIndex1 ==
                                                index
                                            ? const Color.fromRGBO(0, 0, 0, 0.9)
                                            : const Color.fromRGBO(
                                                0, 0, 0, 0.4),
                                      ),
                                    );
                                  }).toList());
                            }),
                            SizedBox(
                              height: size.height / 120,
                            ),
                            BlocBuilder<BlocProductMainScreenCubit,
                                BlocProductMainScreenState>(
                              builder: (builder, state) {
                                BlocProductMainScreenCubit buttonController =
                                    BlocProvider.of<BlocProductMainScreenCubit>(
                                        context);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        !buttonController.searchButton
                                            ? 'Best Selling'
                                            : 'Search Items',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                );
                              },
                            ),
                            SizedBox(
                              height: size.height / 120,
                            ),
                            BlocBuilder<BlocProductMainScreenCubit,
                                    BlocProductMainScreenState>(
                                builder: (builder, state) {
                              BlocProductMainScreenCubit buttonController =
                                  BlocProvider.of<BlocProductMainScreenCubit>(
                                      context);
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 0.0),
                                  child: Center(
                                    child: !buttonController.searchButton
                                        ? fullList1(context)
                                        : customList(context),
                                  ));
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customList(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<BlocProductMainScreenCubit, BlocProductMainScreenState>(
        builder: (builder, state) {
          print(state);
          BlocProductMainScreenCubit productController =
              BlocProvider.of<BlocProductMainScreenCubit>(context);
          if (state is BlocProductMainLoadingScreenState) {
            return LoadingAnimationWidget.fourRotatingDots(
              color: Colors.indigo,
              size: 40,
            );
          }
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: searchItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BlocProductDetailsScreen(
                              price: searchItems[index].price,
                              name: searchItems[index].title,
                              imageURL: searchItems[index].imageUrl,
                              shortDescription: searchItems[index].description,
                              index: index,
                            )));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: searchItems[index].imageUrl.isNotEmpty
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
                                        image: NetworkImage(
                                            searchItems[index].imageUrl),
                                        width: size.width / 2,
                                        height: size.height / 5,
                                      )
                                    : const CircularProgressIndicator()),
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
                                    BlocConsumer<BlocFavoriteScreenCubit,
                                        BlocFavoriteScreenState>(
                                      builder: (builder, state) {
                                        BlocFavoriteScreenCubit
                                            favoriteController = BlocProvider
                                                .of<BlocFavoriteScreenCubit>(
                                                    context);

                                        if (state is BlocFavoriteLoadingState) {
                                          if (productController
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
                                        } else if (state
                                            is BlocFavoriteInitial1State) {}

                                        return Align(
                                          alignment: Alignment.topRight,
                                          child: searchItems[index]
                                                      .watchListItemId !=
                                                  ''
                                              ? InkWell(
                                                  onTap: () async {
                                                    productController
                                                        .updateButtonState(
                                                            index);
                                                    await favoriteController
                                                        .getRemoveFavorite(
                                                            searchItems[index]
                                                                .watchListItemId);

                                                    await searchItemChange();
                                                    productController
                                                        .updateButtonDisableState(
                                                            index);
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
                                                            index);
                                                    await favoriteController
                                                        .getAddInFavorite(
                                                            searchItems[index]
                                                                .id);

                                                    await searchItemChange();
                                                    productController
                                                        .updateButtonDisableState(
                                                            index);
                                                  },
                                                  child: const Icon(
                                                    CupertinoIcons.heart,
                                                    size: 16,
                                                  ),
                                                ),
                                        );
                                      },
                                      listener: (listener, state) {},
                                    ),
                                    SizedBox(
                                      width: size.width,
                                      child: AutoSizeText(
                                        searchItems[index].title,
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
                                          '\$${searchItems[index].price}',
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
                                        searchItems[index].description,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 30),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height / 60,
                                    ),
                                    BlocConsumer<BlocCartScreenCubit,
                                        BlocCartScreenState>(
                                      builder: (builder, state) {
                                        BlocCartScreenCubit cartController =
                                            BlocProvider.of<
                                                BlocCartScreenCubit>(context);

                                        if (state is BlocCartItemLoadingState) {
                                          if (productController
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
                                                    searchItems[index]
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
                                                                      onTap:
                                                                          () async {
                                                                        productController
                                                                            .updateButtonState(index);
                                                                        await cartController
                                                                            .decreaseProductQuantity(searchItems[index].cartItemId);

                                                                        await searchItemChange();
                                                                        productController
                                                                            .updateButtonDisableState(index);
                                                                      },
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.grey[200],
                                                                        // Colors.pink[500],
                                                                        radius:
                                                                            14,
                                                                        child: const Center(
                                                                            child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Colors.black,
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      searchItems[
                                                                              index]
                                                                          .quantity
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        productController
                                                                            .updateButtonState(index);
                                                                        await cartController
                                                                            .increaseProductQuantity(searchItems[index].cartItemId);

                                                                        await searchItemChange();
                                                                        productController
                                                                            .updateButtonDisableState(index);
                                                                      },
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.grey[200],
                                                                        radius:
                                                                            14,
                                                                        child: const Center(
                                                                            child: Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.black,
                                                                        )),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : InkWell(
                                                            onTap: () async {
                                                              productController
                                                                  .updateButtonState(
                                                                      index);
                                                              await cartController
                                                                  .addToCart(
                                                                      searchItems[
                                                                              index]
                                                                          .id);

                                                              await searchItemChange();
                                                              productController
                                                                  .updateButtonDisableState(
                                                                      index);
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
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Text(
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
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Item will be Added in Cart... Please Wait.....!!!!',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          );
                                        } else if (state
                                            is BlocCartDecreaseSuccessfullyState) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                              'Item Quantity will be Decrease... Please Wait.....!!!!',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: Colors.indigo,
                                          ));
                                        } else if (state
                                            is BlocCartIncreaseSuccessfullyState) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                              'Item Quantity will be Increase... Please Wait.....!!!!',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: Colors.indigo,
                                          ));
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
        },
        listener: (listener, state) {});
  }
}

fullList1(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  // return  GetBuilder<GetxProductController>(builder: (controller){

  return BlocConsumer<BlocProductMainScreenCubit, BlocProductMainScreenState>(
    builder: (builder, state) {
      print(state);
      BlocProductMainScreenCubit productController =
          BlocProvider.of<BlocProductMainScreenCubit>(context);
      if (state is BlocProductMainLoadingScreenState) {
        return LoadingAnimationWidget.fourRotatingDots(
          color: Colors.indigo,
          size: 40,
        );
      }

      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: productController.getProductAllAPI.data.length,
          itemBuilder: (context, index) {
            return InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BlocProductDetailsScreen(
                          price: productController
                              .getProductAllAPI.data[index].price,
                          name: productController
                              .getProductAllAPI.data[index].title,
                          imageURL: productController
                              .getProductAllAPI.data[index].imageUrl,
                          shortDescription: productController
                              .getProductAllAPI.data[index].description,
                          index: index,
                        )));
              },
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: productController.getProductAllAPI
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
                                    errorBuilder: (context, error, stackTrace) {
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
                                        .getProductAllAPI.data[index].imageUrl),
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
                                BlocConsumer<BlocFavoriteScreenCubit,
                                    BlocFavoriteScreenState>(
                                  builder: (builder, state) {
                                    BlocFavoriteScreenCubit favoriteController =
                                        BlocProvider.of<
                                            BlocFavoriteScreenCubit>(context);

                                    if (state is BlocFavoriteLoadingState) {
                                      if (productController
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
                                      child: productController
                                                  .getProductAllAPI
                                                  .data[index]
                                                  .watchListItemId !=
                                              ''
                                          ? InkWell(
                                              onTap: () async {
                                                productController
                                                    .updateButtonState(index);
                                                await favoriteController
                                                    .getRemoveFavorite(
                                                        productController
                                                            .getProductAllAPI
                                                            .data[index]
                                                            .watchListItemId);

                                                await productController
                                                    .updateProductAllAPI();
                                                productController
                                                    .updateButtonDisableState(
                                                        index);
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
                                                    .updateButtonState(index);
                                                await favoriteController
                                                    .getAddInFavorite(
                                                        productController
                                                            .getProductAllAPI
                                                            .data[index]
                                                            .id);

                                                await productController
                                                    .updateProductAllAPI();
                                                productController
                                                    .updateButtonDisableState(
                                                        index);
                                              },
                                              child: const Icon(
                                                CupertinoIcons.heart,
                                                size: 16,
                                              ),
                                            ),
                                    );
                                  },
                                  listener: (listener, state) {
                                    print(state);
                                    if (state
                                        is BlocFavoriteAddToFavoriteSuccessfullyState) {
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
                                    } else if (state
                                        is BlocFavoriteRemoveToFavoriteSuccessfullyState) {
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
                                    } else if (state
                                        is BlocFavoriteInitial1State) {}
                                  },
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: AutoSizeText(
                                    productController
                                        .getProductAllAPI.data[index].title,
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
                                      '\$${productController.getProductAllAPI.data[index].price}',
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
                                    productController.getProductAllAPI
                                        .data[index].description,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 30),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 60,
                                ),
                                BlocConsumer<BlocCartScreenCubit,
                                    BlocCartScreenState>(
                                  builder: (builder, state) {
                                    BlocCartScreenCubit cartController =
                                        BlocProvider.of<BlocCartScreenCubit>(
                                            context);

                                    if (state is BlocCartItemLoadingState) {
                                      if (productController
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
                                            child: productController
                                                        .getProductAllAPI
                                                        .data[index]
                                                        .quantity !=
                                                    0
                                                ? Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          child: Container(
                                                            width: size.width,
                                                            height:
                                                                size.height /
                                                                    20,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.pink,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0)),
                                                            child: const Center(
                                                                child: Text(
                                                              'Added in Cart',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                                              onTap: () async {
                                                                productController
                                                                    .updateButtonState(
                                                                        index);
                                                                await cartController.decreaseProductQuantity(
                                                                    productController
                                                                        .getProductAllAPI
                                                                        .data[
                                                                            index]
                                                                        .cartItemId);

                                                                await productController
                                                                    .updateProductAllAPI();
                                                                productController
                                                                    .updateButtonDisableState(
                                                                        index);
                                                              },
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        200],
                                                                // Colors.pink[500],
                                                                radius: 14,
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              ),
                                                            ),
                                                            Text(
                                                              productController
                                                                  .getProductAllAPI
                                                                  .data[index]
                                                                  .quantity
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                productController
                                                                    .updateButtonState(
                                                                        index);
                                                                await cartController.increaseProductQuantity(
                                                                    productController
                                                                        .getProductAllAPI
                                                                        .data[
                                                                            index]
                                                                        .cartItemId);

                                                                await productController
                                                                    .updateProductAllAPI();
                                                                productController
                                                                    .updateButtonDisableState(
                                                                        index);
                                                              },
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        200],
                                                                radius: 14,
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Icon(
                                                                  Icons.add,
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
                                                    onTap: () async {
                                                      productController
                                                          .updateButtonState(
                                                              index);
                                                      await cartController
                                                          .addToCart(
                                                              productController
                                                                  .getProductAllAPI
                                                                  .data[index]
                                                                  .id);

                                                      await productController
                                                          .updateProductAllAPI();
                                                      productController
                                                          .updateButtonDisableState(
                                                              index);
                                                    },
                                                    child: Container(
                                                      width: size.width,
                                                      height: size.height / 20,
                                                      decoration: BoxDecoration(
                                                          color: Colors.indigo,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0)),
                                                      child: const Center(
                                                          child: Text(
                                                        'Add to Cart',
                                                        style: TextStyle(
                                                            color: Colors.white,
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
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Item will be Added in Cart... Please Wait.....!!!!',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    } else if (state
                                        is BlocCartDecreaseSuccessfullyState) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          'Item Quantity will be Decrease... Please Wait.....!!!!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        backgroundColor: Colors.indigo,
                                      ));
                                    } else if (state
                                        is BlocCartIncreaseSuccessfullyState) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          'Item Quantity will be Increase... Please Wait.....!!!!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        backgroundColor: Colors.indigo,
                                      ));
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
    },
    listener: (builder, state) {
      if (state is BlocProductMainJWTNotFoundProductScreenState) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BlocLoginScreen()),
          (route) => false,
        );
      }
    },
  );
}
