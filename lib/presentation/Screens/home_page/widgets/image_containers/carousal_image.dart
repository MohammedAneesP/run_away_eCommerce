import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';

class CarousalImageContainer extends StatelessWidget {
  final String anImage;
  const CarousalImageContainer({
    required this.anImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: kGrey.withOpacity(0.1),
        image: DecorationImage(image: AssetImage(anImage), fit: BoxFit.cover),
      ),
    );
  }
}