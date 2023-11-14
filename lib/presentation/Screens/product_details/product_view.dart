import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/application/cart/cart_button_bloc/cart_button_bloc.dart';
import 'package:run_away/application/product_details/product_view/product_view_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/infrastructure/home_page/brand_name_get.dart';
import 'package:run_away/presentation/Screens/cart/my_cart.dart';
import 'package:run_away/presentation/Screens/wishlist/widgets/favarite_icon/favorite_icon_home.dart';

import 'widgets/pop_back.dart';
import 'widgets/product_image.dart';
import 'widgets/thump_image.dart';

class ProductView extends StatelessWidget {
  final String anProductId;
  ProductView({super.key, required this.anProductId});

  final fireName = FirebaseAuth.instance.currentUser;
  final PageController pageViewCtrl = PageController();

  ValueNotifier<int> anSelectVal = ValueNotifier(-1);
  ValueNotifier<String> anSize = ValueNotifier("");
  ValueNotifier<String> stockUpdate = ValueNotifier("");

  void changeValue(int anItem, String theSize) {
    anSelectVal.value = ValueNotifier(anItem).value;
    anSize.value = ValueNotifier(theSize).value;
  }

  @override
  Widget build(BuildContext context) {
    changeValue(-1, "");
    BlocProvider.of<ProductViewBloc>(context)
        .add(AnProductView(anProductid: anProductId));
    BlocProvider.of<CartButtonBloc>(context)
        .add(CartProducts(anEmail: fireName!.email.toString()));
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    final theHeight = MediaQuery.of(context).size.height;
    double headSize = theHeight < 750 ? 16 : 20;
    double bluThinSize = theHeight < 750 ? 13 : 16;
    double titleSize = theHeight < 750 ? 16 : 22;
    double nonBoldSize = theHeight < 750 ? 15 : 20;
    double greySize = theHeight < 750 ? 12 : 15;
    final kNonboldTitleText =
        GoogleFonts.roboto(fontSize: nonBoldSize, color: kBlack);
    final kBlueThinText = GoogleFonts.roboto(
        color: kBlue, fontSize: bluThinSize, fontWeight: FontWeight.w300);
    final kHeadingText = GoogleFonts.roboto(
        fontWeight: FontWeight.bold, fontSize: headSize, color: kBlack);

    final kTitleText = GoogleFonts.robotoFlex(
        fontWeight: FontWeight.bold, fontSize: titleSize, color: kBlack);
    final kGreySmallText = GoogleFonts.roboto(
        fontWeight: FontWeight.w300,
        
        fontSize: greySize,
        color: kGrey,
        fontStyle: FontStyle.italic);
    return BlocBuilder<ProductViewBloc, ProductViewState>(
      builder: (context, state) {
        if (state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final product = state.products;
          final productName = capitalizeFirstLetter(product["itemName"]);
          Map<dynamic, dynamic> forStockAndSize = {};
          List<dynamic> sizeList = [];
          forStockAndSize = state.products["stockAndSize"];
          forStockAndSize.forEach((key, value) {
            final theSize = int.parse(key);
            sizeList.add(theSize);
          });
          sizeList.sort();
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
                              return ProductImage(
                                kHeight: kHeight,
                                product: product,
                                imageurl: product["productImages"][index],
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const PopBackButton(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FavoriteIconHome(
                                  anEmail: fireName!.email.toString(),
                                  anProductId: anProductId),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: kHeight.height * .65,
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
                            SizedBox(height: kHeight.height * 0.01),
                            Text(productName, style: kTitleText),
                            SizedBox(height: kHeight.height * 0.01),
                            Text("₹ ${product["price"]}.",
                                style: kNonboldTitleText),
                            SizedBox(height: kHeight.height * 0.01),
                            Text(
                              product["description"],
                              style: kGreySmallText,
                              maxLines: 100,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: kHeight.height * 0.02),
                            Text("Size", style: kHeadingText),
                            SizedBox(
                              height: kHeight.height * 0.08,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ValueListenableBuilder(
                                    valueListenable: anSelectVal,
                                    builder: (context, value, child) =>
                                        ChoiceChip(
                                      backgroundColor: kGrey200,
                                      shadowColor: kBlue,
                                      elevation: 5,
                                      shape: const CircleBorder(),
                                      selectedColor: kBlue,
                                      label: CircleAvatar(
                                        backgroundColor: kTransparent,
                                        child: Text(sizeList[index].toString(),
                                            style: buttonTextBlack),
                                      ),
                                      selected: anSelectVal.value == index,
                                      onSelected: (value) {
                                        if (value) {
                                          changeValue(index,
                                              sizeList[index].toString());
                                          int theStock = int.parse(state
                                              .products["stockAndSize"]
                                                  [anSize.value]
                                              .toString());
                                          if (theStock <= 5 && theStock >= 1) {
                                            stockUpdate.value =
                                                "Only few remains";
                                          } else if (theStock == 0) {
                                            stockUpdate.value = "Out of Stock";
                                          } else {
                                            stockUpdate.value = "";
                                          }
                                        }
                                      },
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  width: kWidth.width * 0.03,
                                ),
                                itemCount: sizeList.length,
                              ),
                            ),
                            // SizedBox(height: kHeight.height * 0.02),
                            ValueListenableBuilder(
                              valueListenable: stockUpdate,
                              builder: (context, value, child) {
                                return Text(
                                  stockUpdate.value,
                                  style: const TextStyle(color: kRed),
                                );
                              },
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
                                      Text("₹ ${product["price"]}.",
                                          style: kTitleText),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: kHeight.height * 0.09,
                                  width: kWidth.width * 0.47,
                                  child: SizedBox(
                                    child: BlocBuilder<CartButtonBloc,
                                        CartButtonState>(
                                      builder: (context, state) {
                                        return state.productId
                                                .containsKey(anProductId)
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyCart(),
                                                      ));
                                                },
                                                style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          kBlue),
                                                  shape:
                                                      MaterialStatePropertyAll(
                                                          StadiumBorder()),
                                                ),
                                                child: Text(
                                                  "Go to Cart",
                                                  style: buttontextWhite,
                                                ))
                                            : ElevatedButton(
                                                onPressed: () {
                                                  if (anSelectVal.value < 0) {
                                                    anSnackBarFunc(
                                                        context: context,
                                                        aText:
                                                            "Please Select Size",
                                                        anColor: kRed);
                                                    return;
                                                  } else if (stockUpdate
                                                          .value ==
                                                      "Not Available") {
                                                    anSnackBarFunc(
                                                        context: context,
                                                        aText:
                                                            "Product not Available",
                                                        anColor: kRed);
                                                    return;
                                                  }
                                                  BlocProvider.of<
                                                              CartButtonBloc>(
                                                          context)
                                                      .add(AddingToCart(
                                                          anProductId:
                                                              anProductId
                                                                  .toString(),
                                                          anEmail:
                                                              fireName!
                                                                  .email
                                                                  .toString(),
                                                          anSelectedSize: anSize
                                                              .value
                                                              .toString(),
                                                          anCount: "1",
                                                          anPrice:
                                                              product["price"]
                                                                  .toString()));
                                                  // changeValue(-1, '');
                                                },
                                                style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          kBlue),
                                                  shape:
                                                      MaterialStatePropertyAll(
                                                          StadiumBorder()),
                                                ),
                                                child: Text(
                                                  "Add to cart",
                                                  style: buttontextWhite,
                                                ));
                                      },
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
