import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/wishlist/widgets/favarite_icon/favorite_icon_home.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({
    super.key,
    required this.kWidth,
    required this.kHeight,
    required this.anProductImg,
    required this.textProducts,
    required this.brandName,
    required this.textPrice,
    required this.imageHeight,
    required this.imageWidth,
    required this.anEmail,
    required this.anProductId,
    required this.anOnPressed,
  });
  final double kWidth;
  final double kHeight;
  final double imageHeight;
  final String anProductImg;
  final String textProducts;
  final Widget brandName;
  final String textPrice;
  final double imageWidth;
  final String anEmail;
  final String anProductId;
  final VoidCallback anOnPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: anOnPressed,
      child: Container(
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
              FavoriteIconHome(
                anEmail: anEmail,
                anProductId: anProductId,
              ),
              Transform.flip(
                flipX: true,
                child: Transform.rotate(
                  angle: pi / 12.5,
                  child: CachedNetworkImage(
                    imageUrl: anProductImg,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: imageHeight,
                        width: imageWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                      );
                    },
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
      ),
    );
  }
}
