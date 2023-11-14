import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';

class ThankTextAndLottie extends StatelessWidget {
  const ThankTextAndLottie({
    super.key,
    required this.kHeight,
    required this.kWidth,
  });

  final Size kHeight;
  final Size kWidth;

  @override
  Widget build(BuildContext context) {
    final theHeight = MediaQuery.of(context).size.height;
    double headMedSize = theHeight < 750 ? 13 : 17;
    final kHeadingMedText = GoogleFonts.roboto(
        fontWeight: FontWeight.bold, fontSize: headMedSize, color: kBlack);
    return Column(
      children: [
        Text(
          "Thank you for purchasing from. Hoping more orders from you in future ..!",
          style: kHeadingMedText,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          child: LottieBuilder.network(
            "https://lottie.host/c47b3d77-168b-457c-9cb3-dc210cf5f30e/78egmzHEGc.json",
            height: kHeight.height * 0.16,
            width: kWidth.width * 0.2,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
