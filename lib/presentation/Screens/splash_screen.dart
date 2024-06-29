import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: kWhite,
          image: DecorationImage(
              image: AssetImage(
                'assets/faugetshoes.png',
              ),
              fit: BoxFit.contain),
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
