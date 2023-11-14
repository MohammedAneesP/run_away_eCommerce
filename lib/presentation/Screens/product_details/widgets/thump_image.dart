
import 'dart:math';

import 'package:flutter/material.dart';

class ThumpImage extends StatelessWidget {
  const ThumpImage({
    super.key,
    required this.kWidth,
    required this.anImage,
  });
  final String anImage;
  final Size kWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: Transform.rotate(
        angle: pi / 10.5,
        child: Container(
          width: kWidth.width * 0.15,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                anImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
