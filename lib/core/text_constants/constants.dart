import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/core/color_constants/colors.dart';

final kTextStyleBording1 = GoogleFonts.quicksand(fontSize: 22,fontWeight: FontWeight.bold);
final kTextStyleBording2 = GoogleFonts.quicksand(fontSize: 17);

final textMainTitle = GoogleFonts.rocknRollOne(fontSize: 30,fontWeight: FontWeight.bold);

final loginTitle = GoogleFonts.inter(fontSize: 25,fontWeight: FontWeight.bold);

final italicText = GoogleFonts.roboto(fontStyle: FontStyle.italic,color: kBlue,fontSize: 16,fontWeight: FontWeight.w300);

final kBlueText = GoogleFonts.roboto(color: kBlue,fontSize: 17,fontWeight: FontWeight.w500);

final kTitleText = GoogleFonts.robotoFlex(
    fontWeight: FontWeight.bold, fontSize: 22, color: kBlack);

final kHeadingText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: 20, color: kBlack);
final kNonBoldBigText = GoogleFonts.roboto(
    fontWeight: FontWeight.w500, fontSize: 20, color: kBlack);
final kHeadingMedText = GoogleFonts.roboto(
    fontWeight: FontWeight.bold, fontSize: 17, color: kBlack);

final kSubTitleText = GoogleFonts.roboto(
    fontWeight: FontWeight.w500, fontSize: 15, color: kBlack);

final splashTitle = GoogleFonts.rocknRollOne(fontSize: 70,fontWeight: FontWeight.bold,color: kSplashTitleClr);

final buttontextWhite = GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.normal,color: kWhite);
final buttonTextBlack = GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.normal,color: kBlack);

String capitalizeFirstLetter(String text) {
  if (text == null || text.isEmpty) return text;
  return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
}