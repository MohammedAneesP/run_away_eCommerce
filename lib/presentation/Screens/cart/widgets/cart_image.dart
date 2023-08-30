import 'dart:math';

import 'package:flutter/material.dart';

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