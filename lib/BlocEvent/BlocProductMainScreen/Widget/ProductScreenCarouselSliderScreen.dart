import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/ProductMainScreenBloc.dart';
import '../Bloc/ProductMainScreenEvent.dart';
import '../Bloc/ProductMainScreenState.dart';

class ProductScreenCarouselSliderScreen extends StatelessWidget {
  const ProductScreenCarouselSliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://cdn.dribbble.com/users/7797959/screenshots/15909904/mobile1_4x.jpg',
      'https://images.news18.com/ibnlive/uploads/2020/10/1603427907_apple-iphone-12-pro-preorder-page.jpg?im=FitAndFill,width=1200,height=675',
      'https://cdn.images.express.co.uk/img/dynamic/59/590x/Apple-iPhone-12-stock-1370223.webp?r=1607585056252',
    ];
    Size size = MediaQuery.of(context).size;
    ProductMainScreenBloc productController =
        BlocProvider.of<ProductMainScreenBloc>(context);
    return BlocBuilder<ProductMainScreenBloc, BlocProductMainScreenState>(
      buildWhen: (oldState, newState) {
        return oldState is BlocImageListChangeState;
      },
      builder: (BuildContext context, state) {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  height: 180,
                  onPageChanged: (index, reason) {
                    productController.add(ProductImageListEvent(index));
                  }),
              items: imgList
                  .map((item) => Center(
                      child: Image.network(item,
                          fit: BoxFit.cover, width: size.width / 1.1)))
                  .toList(),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.map((e) {
                  int index = imgList.indexOf(e);
                  return Container(
                    width: 8,
                    height: 8,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: productController.imageList == index
                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList())
          ],
        );
      },
    );
  }
}
