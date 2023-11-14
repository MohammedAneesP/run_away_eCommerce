import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/core/color_constants/colors.dart';

class PopularPickText extends StatelessWidget {
  const PopularPickText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    double medSize = kHeight < 750 ? 13 : 17;
    final kHeadingMedText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: medSize, color: kBlack);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 220, 0),
      child: Text(
        "Popular pick's".toUpperCase(),
        style: kHeadingMedText,
      ),
    );
  }
}