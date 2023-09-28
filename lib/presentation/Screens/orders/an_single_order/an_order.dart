import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/order/an_order_details/an_order_details_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'widgets/app_bar_lead.dart';

class AnSingleOrder extends StatelessWidget {
  final String anOrderKey;
  final String anProductKey;
  const AnSingleOrder({
    super.key,
    required this.anOrderKey,
    required this.anProductKey,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AnOrderDetailsBloc>(context).add(DisplayOrderClearing());
      BlocProvider.of<AnOrderDetailsBloc>(context).add(
          DisplayAnOerder(anOrderKey: anOrderKey, anProductKey: anProductKey));
    });

    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return Scaffold(
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: status == "order placed"
                        ? const StatusData(
                          anWidget: Text(""),
                            delivered: false,
                            orderPlaced: true,
                            readyToDeliver: false,
                            shipped: false,
                          )
                        : status == "shipped"
                            ? const StatusData(
                              anWidget: Text(""),
                                delivered: false,
                                orderPlaced: true,
                                readyToDeliver: false,
                                shipped: true,
                              )
                            : status == "ready to deliver"
                                ? const StatusData(
                                  anWidget: Text("data"),
                                    delivered: false,
                                    orderPlaced: true,
                                    readyToDeliver: true,
                                    shipped: true,
                                  )
                                : const StatusData(
                                  anWidget: Text("data"),
                                    delivered: true,
                                    orderPlaced: true,
                                    readyToDeliver: true,
                                    shipped: true,
                                  ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class StatusData extends StatelessWidget {
  final bool orderPlaced;
  final bool shipped;
  final bool readyToDeliver;
  final bool delivered;
  final Widget anWidget;

  const StatusData(
      {super.key,
      required this.delivered,
      required this.orderPlaced,
      required this.readyToDeliver,
      required this.shipped,
      required this.anWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineTile(
          endChild: anWidget,
          isFirst: orderPlaced,
          beforeLineStyle: orderPlaced == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          afterLineStyle: orderPlaced == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
        ),
        TimelineTile(
          endChild: anWidget,
          isFirst: false,
          isLast: false,
          beforeLineStyle: shipped == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          afterLineStyle: shipped == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
        ),
        TimelineTile(
          isFirst: false,
          endChild: anWidget,
          isLast: false,
          beforeLineStyle: readyToDeliver == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          afterLineStyle: readyToDeliver == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
        ),
        TimelineTile(
          isFirst: false,
          endChild: anWidget,
          isLast: true,
          beforeLineStyle: delivered == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          afterLineStyle: delivered == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
        ),
      ],
    );
  }
}
