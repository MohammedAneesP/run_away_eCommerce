import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/presentation/home_page/home_page.dart';
import 'package:run_away/presentation/my_cart.dart';
import 'package:run_away/presentation/my_categories.dart';
import 'package:run_away/presentation/my_profile.dart';
import 'package:run_away/presentation/my_wishlists.dart';

class BottomNavPage extends StatefulWidget {
  BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int indexPage = 2;

  final screens = [
    const HomePage(),
    const Categories(),
    const MyCart(),
    const MyWishlist(),
    const ProfileScreen()
  ];

  final List<Icon> itemList = [
    const Icon(CupertinoIcons.house_fill),
    const Icon(CupertinoIcons.heart),
    const Icon(CupertinoIcons.bag),
    const Icon(CupertinoIcons.square_grid_2x2),
    const Icon(CupertinoIcons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: kBlue,
        height: 75,
        index: indexPage,
        items: itemList,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
      ),
      body: screens[indexPage],
    );
  }
}
