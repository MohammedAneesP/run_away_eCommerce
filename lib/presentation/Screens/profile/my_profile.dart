import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "My Profile",
          style: kHeadingText,
        ),
      ),
    );
  }
}
