import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/infrastructure/home_page/brand_name_get.dart';

class NewArrivalProduct extends StatelessWidget {
  const NewArrivalProduct({
    super.key,
    required this.product,
    required this.productName,
  });

  final dynamic product;
  final String productName;

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    final screenSize = MediaQuery.of(context).size.height;
    double blueSize = screenSize < 750 ? 15 : 17;
    double titleSize = screenSize < 750 ? 18 : 22;
    double noBoldSize = screenSize < 750 ? 17 : 20;
    final kBlueText = GoogleFonts.roboto(
        color: kBlue, fontSize: blueSize, fontWeight: FontWeight.w500);
    final kTitleText = GoogleFonts.robotoFlex(
        fontWeight: FontWeight.bold, fontSize: titleSize, color: kBlack);
    final kNonBoldBigText = GoogleFonts.roboto(
        fontWeight: FontWeight.w500, fontSize: noBoldSize, color: kBlack);
    return Container(
      height: kHeight.height * 0.17,
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: kHeight.height * 0.8,
            width: kWidth.width * 0.55,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kHeight.height * 0.036),
                  BrandNameStream(
                    popularPros: product,
                    anStyle: kBlueText,
                  ),
                  const SizedBox(height: 5),
                  Text(productName, style: kTitleText),
                  const SizedBox(height: 5),
                  Text("₹ ${product['price']}", style: kNonBoldBigText)
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Transform.flip(
                  flipX: true,
                  child: Transform.rotate(
                    angle: pi / 12.5,
                    child: CachedNetworkImage(
                      imageUrl: product["productImages"][0],
                      placeholder: (context, url) =>
                        const  Center(child:  CircularProgressIndicator()),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: kHeight.height * 0.17,
                          width: kWidth.width * .35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
