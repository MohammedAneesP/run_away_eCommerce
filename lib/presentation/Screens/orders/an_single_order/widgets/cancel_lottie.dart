import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';

class LottieCancelledOrder extends StatelessWidget {
  const LottieCancelledOrder({
    super.key,
    required this.kHeight,
    required this.kWidth,
  });

  final Size kHeight;
  final Size kWidth;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.height;
    double noBoldSize = screenSize < 750 ? 17 : 20;
    final kNonBoldBigText = GoogleFonts.roboto(
        fontWeight: FontWeight.w500, fontSize: noBoldSize, color: kBlack);
        
    return SizedBox(
      height: kHeight.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You have Cancelled this product.",
            style: kNonBoldBigText,
          ),
          LottieBuilder.asset(
            "assets/animation_ln937yqv (1).json",
            height: kHeight.height * 0.2,
            width: kWidth.width * 1,
          ),
        ],
      ),
    );
  }
}
