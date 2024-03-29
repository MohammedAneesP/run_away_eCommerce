import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/domain/models/on_board_model.dart';
import 'package:run_away/presentation/Screens/login_sign_up_pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/landing_datas.dart';

class OnBoardingPage1 extends StatefulWidget {
  const OnBoardingPage1({
    super.key,
  });

  @override
  State<OnBoardingPage1> createState() => _OnBoardingPage1State();
}

class _OnBoardingPage1State extends State<OnBoardingPage1> {
  PageController pageViewCtrl = PageController();
  bool isLastPage = false;
  storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('OnBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    final kHieght = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () async {
                await storeOnBoardInfo();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                }
              },
              child: Text(
                'Skip',
                style: GoogleFonts.montserrat(fontSize: 20),
              ),
            ),
          ],
        ),
        body: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: pageViewCtrl,
          onPageChanged: (value) {
            setState(() => isLastPage = value == 2);
          },
          itemBuilder: (context, index) => LandingPageData(
            kHieght: kHieght,
            imageName: bordingPageData[index].imageName,
            screenText: bordingPageData[index].screenText,
            screenDescri: bordingPageData[index].screenDescri,
          ),
          itemCount: bordingPageData.length,
        ),
        bottomSheet: Container(
          height: kHieght * 0.1,
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: pageViewCtrl,
                  count: 3,
                  effect: const WormEffect(
                    spacing: 10,
                    type: WormType.normal,
                    dotWidth: 15,
                  ),
                  onDotClicked: (index) => pageViewCtrl.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutExpo,
                  ),
                ),
                isLastPage
                    ? TextButton(
                        onPressed: () async {
                          await storeOnBoardInfo();
                          if (context.mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Start",
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          pageViewCtrl.nextPage(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text("Next",
                            style: GoogleFonts.montserrat(fontSize: 20)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<OnBoard> bordingPageData = <OnBoard>[
  OnBoard(
    imageName: "assets/IMG_20240211_121539-removebg-preview.png",
    screenText: "Your next partner for your all day Run.",
    screenDescri:
        "Superior Premium Products from premium Brands,Always On Time",
    buttonColor: Colors.limeAccent,
  ),
  OnBoard(
    imageName: "assets/IMG_20240211_121635-removebg-preview.png",
    screenText: "Nothing else matter,Dream Conquer the world",
    screenDescri: "Run with passion Run on your Own,NeverSettle",
    buttonColor: Colors.limeAccent,
  ),
  OnBoard(
    imageName: "assets/IMG_20240211_121846-removebg-preview.png",
    screenText: "Get Ready to Treat your eyes with amazement",
    screenDescri:
        "Lets start Shopping with us as you like best products awaits you",
    buttonColor: Colors.limeAccent,
  ),
];
