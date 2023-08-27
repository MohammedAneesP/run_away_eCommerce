import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';
import 'package:run_away/presentation/Screens/home_page/home_page.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kGrey200,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: kHeight.height * 0.7,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return SizedBox(
                height: kHeight.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: kHeight.height * 0.1,
                      width: kWidth.width * 0.25,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Transform.rotate(
                        angle: pi / -12,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(carouselImages[0]),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kHeight.height * 0.2,
                      width: kWidth.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: kWidth.width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Product Name", style: kHeadingText),
                                SizedBox(height: kHeight.height * 0.01),
                                Text(
                                  "₹ 4000",
                                  style: kSubTextNonBold,
                                ),
                                SizedBox(height: kHeight.height * 0.01),
                                SizedBox(
                                  width: kWidth.width * 0.27,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        splashColor: kTransparent,
                                        onTap: () {},
                                        child: Container(
                                          width: kWidth.width * 0.08,
                                          height: kHeight.height * 0.04,
                                          decoration: const BoxDecoration(
                                              color: kWhite,
                                              shape: BoxShape.circle),
                                          child: const Icon(Icons.remove),
                                        ),
                                      ),
                                      Text(
                                        "10",
                                        style: kSubTitleText,
                                      ),
                                      InkWell(
                                        splashColor: kTransparent,
                                        onTap: () {},
                                        child: Container(
                                          width: kWidth.width * 0.08,
                                          height: kHeight.height * 0.04,
                                          decoration: const BoxDecoration(
                                              color: kBlue,
                                              shape: BoxShape.circle),
                                          child: const Icon(Icons.add,
                                              color: kWhite),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.delete,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 5,
              color: kTransparent,
            ),
            itemCount: 5,
          ),
        ),
      ),
      bottomSheet: Container(
        height: kHeight.height * 0.25,
        color: kGrey200,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal", style: kNonboldTitleText),
                  Text("₹ 8000", style: kTitleNonBoldText),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping", style: kNonboldTitleText),
                  Text("₹ 150", style: kTitleNonBoldText)
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Cost", style: kTitleNonBoldText),
                  Text("₹ 8150", style: kTitleText)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
