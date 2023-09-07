import 'dart:math';

import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';

class CartProductImage extends StatelessWidget {
  const CartProductImage({
    super.key,
    required this.anImageUrl,
  });

  final String anImageUrl;

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: true,
      child: Transform.rotate(
        angle: pi / 14,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  anImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}


ButtonStyle checkOutButtonStyle(Size kWidth, Size kHeight) {
  return ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(kBlue),
      shape: const MaterialStatePropertyAll(StadiumBorder()),
      fixedSize:
          MaterialStatePropertyAll(Size(kWidth.width, kHeight.height * 0.06)));
}