import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:run_away/application/order/an_order_details/an_order_details_bloc.dart';
import 'package:run_away/application/order/display_orders/displaying_all_orders_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';
import 'package:run_away/presentation/Screens/orders/my_orders.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'widgets/app_bar_lead.dart';
import 'widgets/order_status.dart';
import 'widgets/thank_text.dart';

class AnSingleOrder extends StatelessWidget {
  final String anOrderKey;
  final String anProductKey;
  AnSingleOrder({
    super.key,
    required this.anOrderKey,
    required this.anProductKey,
  });

  final fireName = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AnOrderDetailsBloc>(context).add(
          DisplayAnOerder(anOrderKey: anOrderKey, anProductKey: anProductKey));
    });

    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AnOrderDetailsBloc>(context)
            .add(DisplayOrderClearing());
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kGrey200,
          elevation: 0,
          leading: const AnOrderAppBarLeading(),
          centerTitle: true,
          title: Text(
            "Your Orders",
            style: loginTitle,
          ),
        ),
        body: Scaffold(
          body: BlocBuilder<AnOrderDetailsBloc, AnOrderDetailsState>(
            builder: (context, state) {
              if (state.isLoading == false) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.anOrder.isEmpty) {
                return const Center(
                  child: Text("Something Went Wrong"),
                );
              } else {
                final product = state.anProduct;
                final order = state.anOrder;
                final dateAndTime = order["documentId"].toString().split(" ");
                final String anDate = dateAndTime[0];
                final String status = order["products"][anProductKey]["status"]
                    .toString()
                    .toLowerCase();
                final int quantity =
                    int.parse(order["products"][anProductKey]["count"]);
                final int price =
                    int.parse(order["products"][anProductKey]["price"]);
                final int shipping = int.parse(order["shippingCost"]);
                return Column(
                  children: [
                    Container(
                      height: kHeight.height * 0.15,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: kWhite,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: kWidth.width * 0.23,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        product["productImages"][0]))),
                          ),
                          SizedBox(
                            width: kWidth.width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  product["itemName"],
                                  style: kTitleText,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Ordered in : $anDate",
                                    style: kSubTitleText),
                                Text(
                                  "Price : ${shipping + (price * quantity)}",
                                  style: kHeadingMedText,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    status == "cancelled"
                        ? Container(
                            // color: kWhite,
                            height: kHeight.height * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "You have Cancelled this product.",
                                  style: kNonBoldBigText,
                                ),
                                LottieBuilder.asset(
                                  "assets/animation_ln937yqv (1).json",
                                  height: kHeight.height * 0.2,
                                  width: kWidth.width * 1,
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: status == "order placed"
                                ? const StatusData(
                                    delivered: false,
                                    orderPlaced: true,
                                    readyToDeliver: false,
                                    shipped: false,
                                  )
                                : status == "shipped"
                                    ? const StatusData(
                                        delivered: false,
                                        orderPlaced: true,
                                        readyToDeliver: false,
                                        shipped: true,
                                      )
                                    : status == "ready to deliver"
                                        ? const StatusData(
                                            delivered: false,
                                            orderPlaced: true,
                                            readyToDeliver: true,
                                            shipped: true,
                                          )
                                        : const StatusData(
                                            delivered: true,
                                            orderPlaced: true,
                                            readyToDeliver: true,
                                            shipped: true,
                                          ),
                          ),
                    SizedBox(height: kHeight.height * 0.08),
                    SizedBox(
                      height: kHeight.height * 0.3,
                      child: status == "delivered"
                          ? Center(
                              child: ThankTextAndLottie(
                                  kHeight: kHeight, kWidth: kWidth))
                          : status == "cancelled"
                              ? Center(
                                  child: Container(
                                    // color: kWhite,
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                         Text("Continue shopping with us",style: kNonboldTitleText,),
                                        SizedBox(height: kHeight.height*0.01),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        kBlue),
                                                shape:
                                                    const MaterialStatePropertyAll(
                                                        StadiumBorder()),
                                                fixedSize:
                                                    MaterialStatePropertyAll(
                                                        Size(
                                                            kWidth.width * .5,
                                                            kHeight.height *
                                                                0.07))),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BottomNavPage(),
                                                  ));
                                            },
                                            child: const Text("Go to homePage"))
                                      ],
                                    ),
                                  ),
                                )
                              : Center(
                                  child: SizedBox(
                                    height: kHeight.height * 2,
                                    width: kWidth.width * .9,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                                "Do you Want to Cancel this order"),
                                            OutlinedButton(
                                                onPressed: () async {
                                                  showCircleProgress(context);

                                                  BlocProvider.of<
                                                              AnOrderDetailsBloc>(
                                                          context)
                                                      .add(
                                                    CancellingOrder(
                                                      anOrderKey: anOrderKey,
                                                      anProductKey:
                                                          anProductKey,
                                                    ),
                                                  );
                                                  BlocProvider.of<
                                                              AnOrderDetailsBloc>(
                                                          context)
                                                      .add(
                                                          DisplayOrderClearing());

                                                  BlocProvider.of<
                                                              DisplayingAllOrdersBloc>(
                                                          context)
                                                      .add(OrdersDisplaying(
                                                          anEmail: fireName!
                                                              .email
                                                              .toString()));

                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 1));
                                                  if (context.mounted) {
                                                    snackBar(context,
                                                        "Order Cancelled ❌");
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text("Cancel")),
                                          ],
                                        ),
                                        SizedBox(
                                          height: kHeight.height * 0.02,
                                        ),
                                        ThankTextAndLottie(
                                            kHeight: kHeight, kWidth: kWidth)
                                      ],
                                    ),
                                  ),
                                ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
