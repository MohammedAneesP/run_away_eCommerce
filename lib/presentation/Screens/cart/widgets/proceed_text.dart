import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/core/color_constants/colors.dart';

class ProceedText extends StatelessWidget {
  const ProceedText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theHeight = MediaQuery.of(context).size.height;
    double theSize = theHeight < 750 ? 14 : 18;
    final buttontextWhite = GoogleFonts.inter(
        fontSize: theSize, fontWeight: FontWeight.normal, color: kWhite);
    return Text(
      "Proceed to Buy",
      style: buttontextWhite,
    );
  }
}
