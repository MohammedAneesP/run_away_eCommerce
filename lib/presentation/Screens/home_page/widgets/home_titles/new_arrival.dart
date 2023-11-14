
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/core/color_constants/colors.dart';

class NewArrivalText extends StatelessWidget {
  const NewArrivalText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final kHeight = MediaQuery.of(context).size.height;
    double headSize = kHeight < 750 ? 16 : 20;
    final kHeadingText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: headSize, color: kBlack);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 240, 0),
      child: Text(
        "New Arrivals",
        style: kHeadingText,
      ),
    );
  }
}