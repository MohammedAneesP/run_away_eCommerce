import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class MyWishlist extends StatelessWidget {
  const MyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "WishLists",
          style: kHeadingText,
        ),
      ),
    );
  }
}
