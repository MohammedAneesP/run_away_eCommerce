import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/cart/cart_button_bloc/cart_button_bloc.dart';
import 'package:run_away/application/cart/cart_view/cart_view_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/address.dart/address.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';

import 'widgets/cart_decrement.dart';
import 'widgets/cart_image.dart';
import 'widgets/cart_increment.dart';
import 'widgets/cart_product_img.dart';
import 'widgets/no_product_view.dart';
import 'widgets/proceed_text.dart';

class MyCart extends StatelessWidget {
  MyCart({super.key});

  final fireName = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartViewBloc>(context)
        .add(ProductsInCart(anEmail: fireName!.email.toString()));
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);

    List<ValueNotifier<int>> productPrice = [];
    Map<String, dynamic> idAndQuantity = {};
    List<int> initialPrice = [];
    ValueNotifier<int> subTotalPrice = ValueNotifier(0);

    return BlocBuilder<CartViewBloc, CartViewState>(
      builder: (context, state) {
        if (state.cartProducts.isEmpty) {
          return const NoProductInCart();
        } else {
          productPrice = [];
          idAndQuantity = {};

          initialPrice = [];

          subTotalPrice.value = 0;
          ValueNotifier<int> shipping = ValueNotifier(150);
          ValueNotifier<int> totalCost = ValueNotifier(0);

          for (var i = 0; i < state.cartProducts.length; i++) {
            final thePrice = int.parse(state.cartProducts[i]["price"]);
            totalCost.value += thePrice;
            productPrice.add(ValueNotifier(thePrice));
            initialPrice.add(thePrice);
          }

          return Scaffold(
            backgroundColor: kGrey200,
            appBar: AppBar(
              surfaceTintColor: kTransparent,
              backgroundColor: kGrey200,
              shadowColor: kTransparent,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: kWhite,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                ),
              ),
              centerTitle: true,
              title: Text("Cart", style: kTitleText),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kHeight.height * 0.7,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final cartSize = state.anProductSize;
                    final cartproducts = state.cartProducts[index];
                    final productId = cartproducts["productId"];
                    idAndQuantity[productId] = state.anProductSize[productId];
                    final productName =
                        capitalizeFirstLetter(cartproducts["itemName"]);

                    int intParsing =
                        int.parse(state.anProductSize[productId]["count"]);

                    ValueNotifier<int> anQuantity = ValueNotifier(
                        intParsing); // this will take the single value  of one products quatity

                    ValueNotifier<int> onePrice = productPrice[
                        index]; //with this we can add one product price as we want, by this we get onr products price

                    return SizedBox(
                      height: kHeight.height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CartImage(
                            kHeight: kHeight,
                            kWidth: kWidth,
                            theUrl: cartproducts["productImages"][0],
                          ),
                          SizedBox(
                            height: kHeight.height * 0.2,
                            width: kWidth.width * 0.65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: kWidth.width * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(productName, style: kHeadingText),
                                      SizedBox(height: kHeight.height * 0.01),
                                      ValueListenableBuilder(
                                        valueListenable: onePrice,
                                        builder: (context, value, child) {
                                          return Text(
                                              "₹ ${onePrice.value * anQuantity.value}",
                                              style: kSubTextNonBold);
                                        },
                                      ),
                                      SizedBox(height: kHeight.height * 0.01),
                                      SizedBox(
                                        width: kWidth.width * 0.27,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              splashColor: kTransparent,
                                              onTap: () {
                                                if (anQuantity.value > 1) {
                                                  anQuantity.value -= 1;

                                                  idAndQuantity[productId]
                                                          ["count"] =
                                                      anQuantity.value
                                                          .toString();

                                                  totalCost.value -=
                                                      initialPrice[index];
                                                  BlocProvider.of<CartViewBloc>(
                                                          context)
                                                      .add(CartUpdatingCount(
                                                          anEmail: fireName!
                                                              .email
                                                              .toString(),
                                                          anUpdateMap:
                                                              idAndQuantity));
                                                } else {
                                                  return;
                                                }
                                                if (subTotalPrice.value >=
                                                    20000) {
                                                  shipping.value = 0;
                                                } else {
                                                  shipping.value = 150;
                                                }
                                              },
                                              child: CartReduceIcon(
                                                  kWidth: kWidth,
                                                  kHeight: kHeight),
                                            ),
                                            ValueListenableBuilder(
                                              valueListenable: anQuantity,
                                              builder:
                                                  (context, value, child) =>
                                                      Text(
                                                anQuantity.value.toString(),
                                                style: kSubTitleText,
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: kTransparent,
                                              onTap: () {
                                                final quantity = int.parse(
                                                    cartproducts["stockAndSize"]
                                                        [cartSize[productId]
                                                            ["size"]]);

                                                if (anQuantity.value <
                                                    quantity) {
                                                  anQuantity.value += 1;

                                                  idAndQuantity[productId]
                                                          ["count"] =
                                                      anQuantity.value
                                                          .toString();

                                                  totalCost.value =
                                                      subTotalPrice.value;

                                                  BlocProvider.of<CartViewBloc>(
                                                          context)
                                                      .add(CartUpdatingCount(
                                                          anEmail: fireName!
                                                              .email
                                                              .toString(),
                                                          anUpdateMap:
                                                              idAndQuantity));
                                                } else {
                                                  return;
                                                }
                                                if (subTotalPrice.value >=
                                                    20000) {
                                                  shipping.value = 0;
                                                } else {
                                                  shipping.value = 150;
                                                }
                                              },
                                              child: CartAddIcon(
                                                  kWidth: kWidth,
                                                  kHeight: kHeight),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<CartViewBloc>(context).add(
                                        CartUpdatingCount(
                                            anEmail: fireName!.email.toString(),
                                            anUpdateMap: idAndQuantity));
                                    BlocProvider.of<CartViewBloc>(context).add(
                                        CartItemRemove(
                                            anEmail: fireName!.email.toString(),
                                            anProductId:
                                                cartproducts["productId"]));
                                    idAndQuantity.remove(productId);
                                    BlocProvider.of<CartViewBloc>(context).add(
                                        ProductsInCart(
                                            anEmail:
                                                fireName!.email.toString()));
                                    BlocProvider.of<CartButtonBloc>(context)
                                        .add(CartProducts(
                                            anEmail:
                                                fireName!.email.toString()));
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.delete,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 3,
                    color: kTransparent,
                  ),
                  itemCount: state.cartProducts.length,
                ),
              ),
            ),
            bottomSheet: Container(
              height: kHeight.height * 0.22,
              color: kGrey200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal", style: kNonboldTitleText),
                        ValueListenableBuilder(
                          valueListenable: subTotalPrice,
                          builder: (context, value, child) {
                            for (var i = 0;
                                i < state.cartProducts.length;
                                i++) {
                              int price =
                                  int.parse(state.cartProducts[i]["price"]);
                              int count = int.parse(state.anProductSize[
                                  state.cartProducts[i]["productId"]]["count"]);
                              subTotalPrice.value =
                                  subTotalPrice.value + (price * count);
                            }
                            return Text("₹ ${subTotalPrice.value}",
                                style: kTitleNonBoldText);
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shipping", style: kNonboldTitleText),
                        ValueListenableBuilder(
                          valueListenable: shipping,
                          builder: (context, value, child) {
                            if (subTotalPrice.value >= 20000) {
                              shipping.value = 0;
                            }
                            return Text("₹ ${shipping.value}",
                                style: kTitleNonBoldText);
                          },
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Cost", style: kTitleNonBoldText),
                        ValueListenableBuilder(
                            valueListenable: totalCost,
                            builder: (context, value, child) {
                              totalCost.value =
                                  subTotalPrice.value + shipping.value;
                              return Text("₹ ${totalCost.value}",
                                  style: kTitleText);
                            }),
                      ],
                    ),
                    SizedBox(height: kHeight.height * 0.01),
                    ElevatedButton(
                        style: checkOutButtonStyle(kWidth, kHeight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddressSelecting(),
                          ));
                        },
                        child: const ProceedText())
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
