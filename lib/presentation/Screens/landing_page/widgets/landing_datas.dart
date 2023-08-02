
import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';


class LandingPageData extends StatelessWidget {
  const LandingPageData({
    Key? key,
    required this.kHieght,
    required this.imageName,
    required this.screenText,
    required this.screenDescri,
  }) : super(key: key);

  final double kHieght;
  final String imageName;
  final String screenText;
  final String screenDescri;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kHieght * 0.1,
        ),
        Container(
          height: kHieght * .3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageName), fit: BoxFit.cover)),
        ),
        SizedBox(
          height: kHieght * 0.15,
        ),
        Text(
          screenText,
          textAlign: TextAlign.center,
          style: kTextStyleBording1,
        ),
        SizedBox(
          height: kHieght * 0.05,
        ),
        Text(
          screenDescri,
          textAlign: TextAlign.center,
          style: kTextStyleBording2,
        ),
      ],
    );
  }
}