import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/main.dart';

import 'landing_page/landing_page_1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goto();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.height;
    double splashText = screenSize < 750 ? 50 : 70;
    final splashTitle = GoogleFonts.rocknRollOne(
        fontSize: splashText, fontWeight: FontWeight.bold, color: kSplashTitleClr);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/sports-usain_bolt-266152.jpeg',
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Text(
            "RUNAWAY",
            style: splashTitle,
          ),
        ),
      ),
    );
  }

  Future<void> goto() async {
    await Future.delayed(const Duration(seconds: 5));
    if (context.mounted) {
      isViewed != 0
          ? toOnBoarding()
          : FireBaseAuthMethods(FirebaseAuth.instance).checkLogedIn(context);
    }
  }

  void toOnBoarding() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const OnBoardingPage1(),
    ));
  }
}
