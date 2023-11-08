import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';

class AppbarActionWidg extends StatelessWidget {
  const AppbarActionWidg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: CircleAvatar(
        backgroundColor: kWhite,
        child: IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.heart,
              color: kBlack,
            )),
      ),
    );
  }
}
