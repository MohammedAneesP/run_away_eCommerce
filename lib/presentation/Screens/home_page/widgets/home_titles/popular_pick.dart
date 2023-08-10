import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class PopularPickText extends StatelessWidget {
  const PopularPickText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 220, 0),
      child: Text(
        "Popular pick's".toUpperCase(),
        style: kHeadingMedText,
      ),
    );
  }
}