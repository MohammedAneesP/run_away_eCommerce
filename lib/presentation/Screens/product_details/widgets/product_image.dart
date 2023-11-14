
import 'dart:math';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.kHeight,
    required this.product,
    required this.imageurl,
  });

  final Size kHeight;
  final Map<String, dynamic> product;
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      child: Transform.rotate(
        angle: pi / 10.5,
        child: Container(
          height: kHeight.height * .45,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                imageurl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
