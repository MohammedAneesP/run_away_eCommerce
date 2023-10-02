
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/presentation/Screens/orders/an_single_order/an_order.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'order_track_text.dart';

class StatusData extends StatelessWidget {
  final bool orderPlaced;
  final bool shipped;
  final bool readyToDeliver;
  final bool delivered;

  const StatusData({
    super.key,
    required this.delivered,
    required this.orderPlaced,
    required this.readyToDeliver,
    required this.shipped,
  });

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return Column(
      children: [
        TimelineTile(
          indicatorStyle:
              IndicatorStyle(color: orderPlaced == true ? kGreen : kGrey),
          isFirst: orderPlaced,
          beforeLineStyle: orderPlaced == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          afterLineStyle: orderPlaced == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          endChild: SizedBox(
            height: kHeight.height * 0.1,
            width: kWidth.width * 0.004,
            child: OrderTrackText(
                orderPlaced: orderPlaced, trackText: "Order placed"),
          ),
        ),
        TimelineTile(
            isFirst: false,
            isLast: false,
            indicatorStyle:
                IndicatorStyle(color: shipped == true ? kGreen : kGrey),
            beforeLineStyle: shipped == true
                ? const LineStyle(color: kBlue)
                : const LineStyle(color: kGrey),
            afterLineStyle: shipped == true
                ? const LineStyle(color: kBlue)
                : const LineStyle(color: kGrey),
            endChild: OrderTrackText(
                orderPlaced: shipped, trackText: "Product Shipped")),
        TimelineTile(
          isFirst: false,
          isLast: false,
          indicatorStyle:
              IndicatorStyle(color: readyToDeliver == true ? kGreen : kGrey),
          beforeLineStyle: readyToDeliver == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          afterLineStyle: readyToDeliver == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          endChild: OrderTrackText(
              orderPlaced: readyToDeliver, trackText: "Out For Delivery"),
        ),
        TimelineTile(
          isFirst: false,
          isLast: true,
          indicatorStyle:
              IndicatorStyle(color: delivered == true ? kGreen : kGrey),
          beforeLineStyle: delivered == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          afterLineStyle: delivered == true
              ? const LineStyle(color: kBlue)
              : const LineStyle(color: kGrey),
          endChild:
              OrderTrackText(orderPlaced: delivered, trackText: "Deliverd"),
        ),
      ],
    );
  }
}
