import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';

class NoProductInCart extends StatelessWidget {
  const NoProductInCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: kTransparent,
        backgroundColor: kGrey200,
        shadowColor: kTransparent,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: kWhite,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavPage(),
                    ));
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text("Cart", style: kTitleText),
      ),
      body: Column(
        children: [
          SizedBox(
            height: kHeight.height * 0.35,
            child: LottieBuilder.asset(
              "assets/animation_lnpkse54.json",
              height: kHeight.height * 0.2,
              width: kWidth.width * 1,
            ),
          ),
          const Text("You haven't Ordered any Products"),
          SizedBox(height: kHeight.height * 0.01),
        ],
      ),
    );
  }
}
