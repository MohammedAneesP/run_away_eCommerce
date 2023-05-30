
import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/main.dart';

import 'landing_page/landing_page_1.dart';
import 'login_page/login_page.dart';

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
          image: DecorationImage(
              image: AssetImage(
                'assets/16395871c8dc2b8508923f837c42169b.jpg',
              ),
              fit: BoxFit.cover),
        ),
        child: Center(child: Text("RUNAWAY",style: splashTitle,),),
      ),
    );
  }

  Future<void> goto() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          isViewed != 0 ? const OnBoardingPage1() : const LoginPage(),
    ));
  }
}
