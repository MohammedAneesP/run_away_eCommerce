
import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class OrderTrackText extends StatelessWidget {
  const OrderTrackText({
    super.key,
    required this.orderPlaced,
    required this.trackText,
  });

  final bool orderPlaced;
  final String trackText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
      child: Text(
        trackText,
        style: orderPlaced == true ? kBlueText : kSubTitleText,
      ),
    );
  }
}
