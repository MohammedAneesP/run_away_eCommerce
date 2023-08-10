
import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class NewArrivalText extends StatelessWidget {
  const NewArrivalText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 240, 0),
      child: Text(
        "New Arrivals",
        style: kHeadingText,
      ),
    );
  }
}