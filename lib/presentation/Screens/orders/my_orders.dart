import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/order/display_orders/displaying_all_orders_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';
import 'package:run_away/presentation/Screens/orders/an_single_order/an_order.dart';
import 'package:run_away/presentation/Screens/wishlist/widgets/appbar_widgets/leading_widget.dart';

class MyOrders extends StatelessWidget {
  MyOrders({super.key});

  final fireName = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DisplayingAllOrdersBloc>(context)
          .add(OrdersDisplaying(anEmail: fireName!.email.toString()));
    });

    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavPage(),
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: const AppbarLeading(),
          centerTitle: true,
          title: Text(
            "Orders",
            style: loginTitle,
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<DisplayingAllOrdersBloc, DisplayingAllOrdersState>(
            builder: (context, state) {
              if (state.isLoading == true) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.userOrderKey.isEmpty) {
                return const Center(child: Text("No orders made yet!"));
              } else {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final anOrderKey = state.userOrderKey[index].toString();
                    final anProductKey = state.userProductKey[index].toString();

                    final String productName = capitalizeFirstLetter(
                        state.products[anProductKey]["itemName"].toString());

                    final dateAndTime = anOrderKey.split(" ");

                    final String anDate = dateAndTime[0];
                    final String productImage = state.products[anProductKey]
                            ["productImages"][0]
                        .toString();

                    final String theStatus = state.orders[anOrderKey]
                            ["products"][anProductKey]["status"]
                        .toString();

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnSingleOrder(
                                  anOrderKey:
                                      state.userOrderKey[index].toString(),
                                  anProductKey:
                                      state.userProductKey[index].toString()),
                            ),
                          );
                        },
                        child: Container(
                          height: kHeight.height * 0.11,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            // color: kWhite,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: kWidth.width * 0.23,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(productImage))),
                                ),
                              ),
                              SizedBox(
                                width: kWidth.width * 0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      productName,
                                      style: kTitleText,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text("Ordered in : $anDate",
                                        style: kSubTitleText),
                                    Text("Status : $theStatus",
                                        style: kSubTitleText),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: kWidth.width * 0.1,
                                child: const Icon(Icons.chevron_right),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: kHeight.height * 0.0001,
                    // color: kTransparent,
                  ),
                  itemCount: state.userProductKey.length,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
