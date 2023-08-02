
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/wishlist/widgets/favorite_icon.dart';

class ProductGridTile extends StatelessWidget {
   ProductGridTile({
    super.key,
    required this.kWidth,
    required this.kHeight,
    required this.anProductImg,
    required this.textProducts,
    required this.brandName,
    required this.textPrice,
    required this.imageHeight,
    required this.imageWidth,
    required this.anEmil,
    required this.anProductId,
  });
  final double kWidth;
  final double kHeight;
  final double imageHeight;
  final String anProductImg;
  final String textProducts;
  final Widget brandName;
  final String textPrice;
  final double imageWidth;
  final String anEmil;
  final String anProductId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight,
      width: kWidth,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FavoriteIcon(
             // anBool: anBool,
              anEmil: anEmil,
              anProductId: anProductId,
            ),
            Transform.flip(
              flipX: true,
              child: Transform.rotate(
                angle: pi / 12.5,
                child: Container(
                  height: imageHeight,
                  width: imageWidth,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    image: DecorationImage(
                        image: NetworkImage(anProductImg), fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    brandName,
                    const SizedBox(height: 2),
                    Text(textProducts, style: kHeadingMedText),
                    const SizedBox(height: 3),
                    Text("₹ $textPrice", style: kSubTitleText),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
  