import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../BlocLogin/LoginPageUI.dart';
import '../../BlocProductMainScreen/Bloc/ProductMainScreenBloc.dart';
import '../../BlocProductMainScreen/Bloc/ProductMainScreenState.dart';
import '../Bloc/CartMainScreenBloc.dart';
import '../Bloc/CartMainScreenEvent.dart';
import '../Bloc/CartMainScreenState.dart';

class CartMainScreenListView extends StatelessWidget {
  const CartMainScreenListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = BlocProvider.of<CartMainScreenBloc>(context);
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CartMainScreenBloc, BlocCartScreenState>(
        builder: (builder, state) {
      if (state is BlocCartLoadingState) {
        return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
          color: Colors.indigo,
          size: 40,
        ));
      }
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
          : BlocConsumer<ProductMainScreenBloc, BlocProductMainScreenState>(
              builder: (builder, state) {
                return ListView.builder(
                    itemCount:
                        cartController.blocCartAddItemModelClass.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Column(children: [
                        Row(children: [
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
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
                                              fontWeight: FontWeight.w300,
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
                                              fontWeight: FontWeight.w300,
                                              fontSize: 30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height / 70,
                                      ),
                                      BlocConsumer<CartMainScreenBloc,
                                          BlocCartScreenState>(
                                        listener: (listener, state) {
                                          if (state
                                              is BlocCartDecreaseSuccessfullyState) {
                                            context
                                                .read<CartMainScreenBloc>()
                                                .add(
                                                    BlocCartAllDataUpdateEvent());

                                            context
                                                .read<CartMainScreenBloc>()
                                                .add(BlocCartUpdateButton2Event(
                                                    false, index));
                                          } else if (state
                                              is BlocCartIncreaseSuccessfullyState) {
                                            context
                                                .read<CartMainScreenBloc>()
                                                .add(
                                                    BlocCartAllDataUpdateEvent());

                                            context
                                                .read<CartMainScreenBloc>()
                                                .add(BlocCartUpdateButton2Event(
                                                    false, index));
                                          } else if (state
                                              is BlocCartRemoveFromCartSuccessfullyState) {
                                            context
                                                .read<CartMainScreenBloc>()
                                                .add(
                                                    BlocCartAllDataUpdateEvent());

                                            context
                                                .read<CartMainScreenBloc>()
                                                .add(BlocCartUpdateButton2Event(
                                                    false, index));
                                          }
                                        },
                                        builder: (builder, state) {
                                          if (state
                                              is BlocCartItemLoadingState) {
                                            if (cartController
                                                .isLoadingList[index]) {
                                              return LoadingAnimationWidget
                                                  .fourRotatingDots(
                                                color: Colors.indigo,
                                                size: 40,
                                              );
                                            }
                                          }
                                          return Row(children: [
                                            Expanded(
                                              child: SizedBox(
                                                width: size.width,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: AutoSizeText(
                                                    '\$${cartController.blocCartAddItemModelClass.data[index].productDetails!.price}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                key:Key('Cart_Screen_delete_item:-$index'),
                                                  onPressed: () async {
                                                    context
                                                        .read<
                                                            CartMainScreenBloc>()
                                                        .add(
                                                            BlocCartUpdateButtonEvent(
                                                                true, index));

                                                    cartController.add(
                                                        BlocCartRemoveFromCartEvent(
                                                            cartController
                                                                .blocCartAddItemModelClass
                                                                .data[index]
                                                                .id));
                                                  },
                                                  icon: const Icon(
                                                      CupertinoIcons.delete)),
                                            ),
                                            Expanded(
                                                child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  key: Key('Cart_Screen_decrease_item_count:-$index'),

                                                  onTap: () async {
                                                    context
                                                        .read<
                                                            CartMainScreenBloc>()
                                                        .add(
                                                            BlocCartUpdateButtonEvent(
                                                                true, index));
                                                    context
                                                        .read<
                                                            CartMainScreenBloc>()
                                                        .add(BlocCartDecreaseProductQuantityEvent(
                                                            cartController
                                                                .blocCartAddItemModelClass
                                                                .data[index]
                                                                .id));
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    // Colors.pink[500],
                                                    radius: 14,
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.remove,
                                                      color: Colors.black,
                                                    )),
                                                  ),
                                                ),
                                                Text(
                                                  cartController
                                                      .blocCartAddItemModelClass
                                                      .data[index]
                                                      .quantity
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                InkWell(
                                                  key: Key('Cart_Screen_increase_item_count:-$index'),
                                                  onTap: () async {
                                                    context
                                                        .read<
                                                            CartMainScreenBloc>()
                                                        .add(
                                                            BlocCartUpdateButtonEvent(
                                                                true, index));
                                                    context
                                                        .read<
                                                            CartMainScreenBloc>()
                                                        .add(BlocCartIncreaseProductQuantityEvent(
                                                            cartController
                                                                .blocCartAddItemModelClass
                                                                .data[index]
                                                                .id));
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    radius: 14,
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ))
                                          ]);
                                        },
                                      ),
                                    ],
                                  )))
                        ])
                      ]));
                    });
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
