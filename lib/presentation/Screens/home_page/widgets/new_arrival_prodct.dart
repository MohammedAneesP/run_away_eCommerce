import 'dart:math';

import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
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

    return Container(
      height: kHeight.height*0.17,
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
           // color: Colors.amberAccent,
            height: kHeight.height*0.8,
            width: kWidth.width*0.55,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
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
                    child: Container(
                      height: kHeight.height*0.17,
                      width: kWidth.width*.35,
                      decoration: BoxDecoration(
                      //  color: Colors.blue,
                        image: DecorationImage(
                          image: NetworkImage(
                            product["productImages"][0],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
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
