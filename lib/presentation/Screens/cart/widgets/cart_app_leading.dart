
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';

class CartAppLeading extends StatelessWidget {
  const CartAppLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: kWhite,
        child: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
    );
  }
}
