import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';

class CartAddIcon extends StatelessWidget {
  const CartAddIcon({
    super.key,
    required this.kWidth,
    required this.kHeight,
  });

  final Size kWidth;
  final Size kHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kWidth.width * 0.08,
      height: kHeight.height * 0.04,
      decoration: const BoxDecoration(color: kBlue, shape: BoxShape.circle),
      child: const Icon(Icons.add, color: kWhite),
    );
  }
}