import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../BlocCartMainScreen/CartMainScreen.dart';
import '../Bloc/ProductMainScreenBloc.dart';
import '../Bloc/ProductMainScreenEvent.dart';
import '../Bloc/ProductMainScreenState.dart';

class ProductMainScreenAppBarActionWidget extends StatelessWidget {
  const ProductMainScreenAppBarActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int totalItem = BlocProvider.of<ProductMainScreenBloc>(context)
        .getProductAllAPI
        .totalProduct;
    return Padding(
        padding: const EdgeInsets.only(top: 12.0, right: 12.0),
        child: InkWell(
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
                BlocBuilder<ProductMainScreenBloc, BlocProductMainScreenState>(
                  buildWhen: (oldState, newState) {
                    return oldState is! BlocProductMainScreenUpdateState ||
                        oldState is BlocProductMainGetProductScreenState;
                  },
                  builder: (BuildContext context, state) {
                    totalItem = context
                        .read<ProductMainScreenBloc>()
                        .getProductAllAPI
                        .totalProduct;
                    context
                        .read<ProductMainScreenBloc>()
                        .add(ProductTotalItemEvent());

                    if (state is BlocProductTotalItemState) {
                      totalItem =
                          context.read<ProductMainScreenBloc>().totalProduct;
                    }

                    return Positioned(
                      right: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red[900]),
                          width: 34 / 2,
                          height: 34 / 2,
                          child: Text(
                            totalItem.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
