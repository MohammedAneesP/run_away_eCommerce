import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/product_details/product_view/product_view_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/infrastructure/home_page/brand_name_get.dart';

class ProductView extends StatelessWidget {
  final String anProductId;
  ProductView({super.key, required this.anProductId});

  final PageController pageViewCtrl = PageController();

  ValueNotifier<int> anSelectVal = ValueNotifier(-1);

  void changeValue(int anItem) {
    anSelectVal.value = ValueNotifier(anItem).value;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductViewBloc>(context)
        .add(AnProductView(anProductid: anProductId));
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return BlocBuilder<ProductViewBloc, ProductViewState>(
      builder: (context, state) {
        if (state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final product = state.products;
          final productName = capitalizeFirstLetter(product["itemName"]);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: kHeight.height * .45,
                          child: PageView.builder(
                            itemCount: product["productImages"].length,
                            scrollDirection: Axis.horizontal,
                            controller: pageViewCtrl,
                            itemBuilder: (context, index) {
                              return Transform.flip(
                                child: Transform.rotate(
                                  angle: pi / 10.5,
                                  child: Container(
                                    height: kHeight.height * .45,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          product["productImages"][index],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const PopBackButton(),
                      ],
                    ),
                    Container(
                      height: kHeight.height * .55,
                      decoration: const BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: kHeight.height * 0.07,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        pageViewCtrl.jumpToPage(index);
                                      },
                                      child: ThumpImage(
                                          kWidth: kWidth,
                                          anImage: product["productImages"]
                                              [index]),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: kWidth.width * 0.03,
                                    );
                                  },
                                  itemCount: product["productImages"].length),
                            ),
                            SizedBox(height: kHeight.height * 0.03),
                            BrandNameStream(
                                popularPros: state.products,
                                anStyle: kBlueThinText),
                            SizedBox(height: kHeight.height * 0.02),
                            Text(productName, style: kTitleText),
                            SizedBox(height: kHeight.height * 0.02),
                            Text("₹ ${product["price"]}.",
                                style: kNonboldTitleText),
                            SizedBox(height: kHeight.height * 0.02),
                            Text(
                              product["description"],
                              style: kGreySmallText,
                              maxLines: 100,
                            ),
                            SizedBox(height: kHeight.height * 0.02),
                            Text("Size", style: kHeadingText),
                            SizedBox(
                              height: kHeight.height * 0.067,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ValueListenableBuilder(
                                    valueListenable: anSelectVal,
                                    builder: (context, value, child) =>
                                        ChoiceChip(
                                          shadowColor: kGrey,
                                          elevation:5 ,
                                          shape:const CircleBorder(),
                                          selectedColor: kBlue,
                                          label: CircleAvatar(
                                            backgroundColor: kTransparent,
                                            child: Text(product["shoeSize"][index]
                                                .toString(),style:buttonTextBlack),
                                          ),
                                          selected: anSelectVal.value == index,
                                          onSelected: (value) {
                                            changeValue(index);
                                          },
                                        ),
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  width: kWidth.width * 0.03,
                                ),
                                itemCount: product["shoeSize"].length,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: kHeight.height * 0.1,
                                  width: kWidth.height * 0.215,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      Text("Price", style: kGreyItalicText),
                                      Text("₹ ${product["price"]}.", style: kTitleText),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: kHeight.height * 0.08,
                                  width: kWidth.width * 0.47,
                                  child: SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(kBlue),
                                        shape: MaterialStatePropertyAll(
                                            StadiumBorder()),
                                      ),
                                      child: Text(
                                        "Add to Cart",
                                        style: buttontextWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class PopBackButton extends StatelessWidget {
  const PopBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: kWhite,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back)),
      ),
    );
  }
}

class ThumpImage extends StatelessWidget {
  const ThumpImage({
    super.key,
    required this.kWidth,
    required this.anImage,
  });
  final String anImage;
  final Size kWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: Transform.rotate(
        angle: pi / 10.5,
        child: Container(
          width: kWidth.width * 0.15,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                anImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductViewLeading extends StatelessWidget {
  const ProductViewLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: kWhite,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: kBlack,
          ),
        ),
      ),
    );
  }
}
