import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../BlocCartMainScreen/Bloc/CartMainScreenBloc.dart';
import '../BlocCartMainScreen/Bloc/CartMainScreenEvent.dart';
import '../BlocCartMainScreen/Bloc/CartMainScreenState.dart';
import '../ModelClassBlocEvent/BlocProductMainScreenModel.dart';
import '../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenBloc.dart';
import '../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenEvent.dart';
import '../BlocFavouriteMainScreen/Bloc/BlocFavouriteScreenState.dart';
import '../Utils/BlocDrawerWidget.dart';
import 'Bloc/ProductMainScreenBloc.dart';
import 'Bloc/ProductMainScreenEvent.dart';
import 'Widget/ProductMainScreenAppBarActionWidget.dart';
import 'Bloc/ProductMainScreenState.dart';
import 'Widget/ProductMainScreenItems.dart';
import 'Widget/ProductScreenCarouselSliderScreen.dart';

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

  List<BlocProductAllAPIData> searchItems = [];
  int currentIndex = 0;
  int totalItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchItemChange();
  }

  searchItemChange() async {
    ProductMainScreenBloc productController =
        BlocProvider.of<ProductMainScreenBloc>(context);
    productController.add(ProductAllItemShowingEvent());
    totalItem = productController.getProductAllAPI.totalProduct;
    searchController.clear();
    searchItems = productController.getProductAllAPI.data;
  }

  void onSearchTextChanged(String text) {
    ProductMainScreenBloc productController =
        BlocProvider.of<ProductMainScreenBloc>(context);

    List<BlocProductAllAPIData> result = [];
    if (text.isEmpty) {
      result = productController.getProductAllAPI.data;
    } else {
      result = productController.getProductAllAPI.data
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }
    searchItems = result;
  }

  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductMainScreenBloc productController =
        BlocProvider.of<ProductMainScreenBloc>(context);
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
                actions: const [ProductMainScreenAppBarActionWidget()]),
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
                            BlocBuilder<ProductMainScreenBloc,
                                    BlocProductMainScreenState>(
                                builder: (builder, state) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: CupertinoSearchTextField(
                                      key: const Key('Product_search_textField'),
                                      backgroundColor: Colors.white,
                                      itemSize: size.height / 33,
                                      controller: searchController,
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          onSearchTextChanged(value);
                                          productController.add(
                                              ProductSearchButtonPressEvent(
                                                  false));
                                        } else {
                                          onSearchTextChanged(value);
                                          productController.add(
                                              ProductSearchButtonPressEvent(
                                                  true));
                                        }
                                      },
                                      onSuffixTap: () {
                                        productController.add(
                                            ProductSearchButtonPressEvent(
                                                false));
                                        searchController.clear();
                                        onSearchTextChanged('');
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
                            const ProductScreenCarouselSliderScreen(),
                            SizedBox(
                              height: size.height / 120,
                            ),
                            BlocBuilder<ProductMainScreenBloc,
                                BlocProductMainScreenState>(
                              builder: (builder, state) {
                                ProductMainScreenBloc buttonController =
                                    BlocProvider.of<ProductMainScreenBloc>(
                                        context);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        !buttonController.isSearchButtonPress
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
                            BlocBuilder<ProductMainScreenBloc,
                                    BlocProductMainScreenState>(
                                builder: (builder, state) {
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 0.0),
                                  child: Center(
                                      child:
                                          !productController.isSearchButtonPress
                                              ? const ProductMainScreenItems()
                                              : customSearchBar()));
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

  Widget customSearchBar() {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ProductMainScreenBloc, BlocProductMainScreenState>(
        builder: (builder, state) {
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
            return Card(
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
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                                  image:
                                      NetworkImage(searchItems[index].imageUrl),
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
                                ProductMainScreenBloc productController =
                                    BlocProvider.of<ProductMainScreenBloc>(
                                        context);
                                if (state is BlocFavoriteLoadingState) {
                                  if (productController.isLoadingList[index]) {
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
                                  child: searchItems[index].watchListItemId !=
                                          ''
                                      ? InkWell(
                                          onTap: () async {
                                            context
                                                .read<ProductMainScreenBloc>()
                                                .add(ProductUpdateButtonEvent(
                                                    true, index));
                                            context.read<FavouriteScreenBloc>().add(
                                                BlocFavouriteRemoveProductEvent(
                                                    searchItems[index]
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
                                                    true, index));
                                            context
                                                .read<FavouriteScreenBloc>()
                                                .add(
                                                    BlocFavouriteAddProductEvent(
                                                        searchItems[index].id));
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
                                      ProductUpdateButton2Event(false, index));
                                } else if (state
                                    is BlocFavoriteRemoveToFavoriteSuccessfullyState) {
                                  context
                                      .read<ProductMainScreenBloc>()
                                      .add(ProductAllItemUpdateEvent());

                                  context.read<ProductMainScreenBloc>().add(
                                      ProductUpdateButton2Event(false, index));
                                }
                              }),
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
                              BlocConsumer<CartMainScreenBloc,
                                  BlocCartScreenState>(
                                builder: (builder, state) {
                                  if (state is BlocCartItemLoadingState) {
                                    if (BlocProvider.of<ProductMainScreenBloc>(
                                            context)
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
                                          child: searchItems[index].quantity !=
                                                  0
                                              ? Row(
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
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
                                                              context
                                                                  .read<
                                                                      ProductMainScreenBloc>()
                                                                  .add(ProductUpdateButtonEvent(
                                                                      true,
                                                                      index));
                                                              context
                                                                  .read<
                                                                      CartMainScreenBloc>()
                                                                  .add(BlocCartDecreaseProductQuantityEvent(
                                                                      searchItems[
                                                                              index]
                                                                          .cartItemId));
                                                            },
                                                            child: CircleAvatar(
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
                                                            searchItems[index]
                                                                .quantity
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              context
                                                                  .read<
                                                                      ProductMainScreenBloc>()
                                                                  .add(ProductUpdateButtonEvent(
                                                                      true,
                                                                      index));
                                                              context
                                                                  .read<
                                                                      CartMainScreenBloc>()
                                                                  .add(BlocCartIncreaseProductQuantityEvent(
                                                                      searchItems[
                                                                              index]
                                                                          .cartItemId));
                                                            },
                                                            child: CircleAvatar(
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
                                            key : Key('Search_product_add_to_cart:-$index'),
                                                  onTap: () async {
                                                    context
                                                        .read<
                                                            ProductMainScreenBloc>()
                                                        .add(
                                                            ProductUpdateButtonEvent(
                                                                true, index));
                                                    context
                                                        .read<
                                                            CartMainScreenBloc>()
                                                        .add(
                                                            BlocCartAddToCartEvent(
                                                                searchItems[
                                                                        index]
                                                                    .id));
                                                  },
                                                  child: Container(
                                                    width: size.width,
                                                    height: size.height / 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.indigo,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                    child: const Center(
                                                        child: Text(
                                                      'Add to Cart',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
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

                                    context.read<ProductMainScreenBloc>().add(
                                        ProductUpdateButton2Event(
                                            false, index));
                                  } else if (state
                                      is BlocCartDecreaseSuccessfullyState) {
                                    context
                                        .read<ProductMainScreenBloc>()
                                        .add(ProductAllItemUpdateEvent());

                                    context.read<ProductMainScreenBloc>().add(
                                        ProductUpdateButton2Event(
                                            false, index));
                                  } else if (state
                                      is BlocCartIncreaseSuccessfullyState) {
                                    context
                                        .read<ProductMainScreenBloc>()
                                        .add(ProductAllItemUpdateEvent());

                                    context.read<ProductMainScreenBloc>().add(
                                        ProductUpdateButton2Event(
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
            );
          });
    }, listener: (listener, state) {
      if (state is BlocProductMainScreenUpdateState) {
        onSearchTextChanged(searchController.text);
      } else if (state is BlocProductTotalItemState) {
        onSearchTextChanged(searchController.text);
      }
    });
  }
}
