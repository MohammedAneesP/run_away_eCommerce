import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/cart/cart_view/cart_view_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';

import 'widgets/cart_image.dart';
import 'widgets/no_product_view.dart';

class MyCart extends StatelessWidget {
  MyCart({super.key});

  final fireName = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    ValueNotifier anQuantity = ValueNotifier(1);
    BlocProvider.of<CartViewBloc>(context)
        .add(ProductsInCart(anEmail: fireName!.email.toString()));
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return BlocBuilder<CartViewBloc, CartViewState>(
      builder: (context, state) {
        if (state.cartProducts.isEmpty) {
          return const NoProductInCart();
        } else {}
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavPage(),
                        ));
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
                  final cartproducts = state.cartProducts[index];
                  return SizedBox(
                    height: kHeight.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: kHeight.height * 0.1,
                          width: kWidth.width * 0.25,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CartProductImage(
                              anImageUrl: cartproducts["productImages"][0]),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartproducts["itemName"],
                                        style: kHeadingText),
                                    SizedBox(height: kHeight.height * 0.01),
                                    Text(
                                      "₹ ${cartproducts["price"]}",
                                      style: kSubTextNonBold,
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
                                              
                                            },
                                            child: Container(
                                              width: kWidth.width * 0.08,
                                              height: kHeight.height * 0.04,
                                              decoration: const BoxDecoration(
                                                  color: kWhite,
                                                  shape: BoxShape.circle),
                                              child: const Icon(Icons.remove),
                                            ),
                                          ),
                                          Text(
                                            "10",
                                            style: kSubTitleText,
                                          ),
                                          InkWell(
                                            splashColor: kTransparent,
                                            onTap: () {},
                                            child: Container(
                                              width: kWidth.width * 0.08,
                                              height: kHeight.height * 0.04,
                                              decoration: const BoxDecoration(
                                                  color: kBlue,
                                                  shape: BoxShape.circle),
                                              child: const Icon(Icons.add,
                                                  color: kWhite),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.delete,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                  color: kTransparent,
                ),
                itemCount: state.cartProducts.length,
              ),
            ),
          ),
          bottomSheet: Container(
            height: kHeight.height * 0.3,
            color: kGrey200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal", style: kNonboldTitleText),
                      Text("₹ 8000", style: kTitleNonBoldText),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping", style: kNonboldTitleText),
                      Text("₹ 150", style: kTitleNonBoldText)
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Cost", style: kTitleNonBoldText),
                      Text("₹ 8150", style: kTitleText)
                    ],
                  ),
                  SizedBox(height: kHeight.height * 0.01),
                  ElevatedButton(
                      style: checkOutButtonStyle(kWidth, kHeight),
                      onPressed: () {},
                      child: const Text("Checkout"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

ButtonStyle checkOutButtonStyle(Size kWidth, Size kHeight) {
  return ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(kBlue),
      shape: const MaterialStatePropertyAll(StadiumBorder()),
      fixedSize:
          MaterialStatePropertyAll(Size(kWidth.width, kHeight.height * 0.05)));
}
