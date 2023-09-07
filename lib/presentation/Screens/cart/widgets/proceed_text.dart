import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class ProceedText extends StatelessWidget {
  const ProceedText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Proceed to Buy",
      style: buttontextWhite,
    );
  }
}