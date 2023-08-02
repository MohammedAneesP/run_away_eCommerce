import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Categories",
          style: kHeadingText,
        ),
      ),
    );
  }
}
