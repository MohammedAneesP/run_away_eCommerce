import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/cart/widgets/cart_product_img.dart';

class NoAddressBottomsheet extends StatelessWidget {
  const NoAddressBottomsheet({
    super.key,
    required this.kHeight,
    required this.subtotal,
    required this.shipping,
    required this.totalCost,
    required this.kWidth,
  });

  final Size kHeight;
  final int subtotal;
  final int shipping;
  final int totalCost;
  final Size kWidth;

  @override
  Widget build(BuildContext context) {
    final theHeight = MediaQuery.of(context).size.height;

    double headSize = theHeight < 750 ? 15 : 20;
    double titleNonSize = theHeight < 750 ? 16 : 22;
    double theSize = theHeight < 750 ? 14 : 18;

    final buttontextWhite = GoogleFonts.inter(
        fontSize: theSize, fontWeight: FontWeight.normal, color: kWhite);

    final kNonboldTitleText =
        GoogleFonts.roboto(fontSize: headSize, color: kBlack);
    final kTitleNonBoldText =
        GoogleFonts.robotoFlex(fontSize: titleNonSize, color: kBlack);
    final kTitleText = GoogleFonts.robotoFlex(
        fontWeight: FontWeight.bold, fontSize: titleNonSize, color: kBlack);
    return Container(
      height: kHeight.height * 0.23,
      color: kWhite,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            SizedBox(
              height: kHeight.height * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: kNonboldTitleText),
                Text('$subtotal', style: kTitleNonBoldText)
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping", style: kNonboldTitleText),
                Text("₹ $shipping", style: kTitleNonBoldText)
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Cost", style: kTitleNonBoldText),
                Text("₹ $totalCost", style: kTitleText)
              ],
            ),
            SizedBox(height: kHeight.height * 0.01),
            ElevatedButton(
                style: checkOutButtonStyle(kWidth, kHeight),
                onPressed: () {
                  snackBar(context, "Please add an Address to Continue ⚠️");
                },
                child: Text(
                  "Continue to Pay",
                  style: buttontextWhite,
                ))
          ],
        ),
      ),
    );
  }
}
