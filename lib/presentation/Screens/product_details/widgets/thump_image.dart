import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
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
        child: CachedNetworkImage(
          imageUrl: anImage,
          placeholder: (context, url) => const CircularProgressIndicator(),
          imageBuilder: (context, imageProvider) {
            return Container(
              width: kWidth.width * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
