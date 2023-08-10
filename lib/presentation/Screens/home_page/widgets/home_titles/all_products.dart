
import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class AllProductText extends StatelessWidget {
  const AllProductText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 247, 0),
      child: Text(
        "All products",
        style: kHeadingText,
      ),
    );
  }
}