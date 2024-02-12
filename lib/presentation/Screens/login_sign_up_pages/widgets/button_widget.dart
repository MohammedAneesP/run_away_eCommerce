import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class AnElevatedButton extends StatelessWidget {
  const AnElevatedButton(
      {super.key,
      required this.forFormKey,
      required this.emailController,
      required this.passwordController,
      required this.anString,
      required this.anOnPressed});

  final GlobalKey<FormState> forFormKey;
  final TextEditingController emailController;
  final String anString;
  final TextEditingController passwordController;
  final VoidCallback anOnPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: anOnPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
        ),
      ),
      child: Text(
        anString,
        style: buttontextWhite,
      ),
    );
  }
}
