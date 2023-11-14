
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';

class ProductViewLeading extends StatelessWidget {
  const ProductViewLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: kWhite,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: kBlack,
          ),
        ),
      ),
    );
  }
}
