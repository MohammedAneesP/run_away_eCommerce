import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/presentation/Screens/home_page/home_page.dart';
import 'package:run_away/presentation/Screens/categories/my_categories.dart';
import 'package:run_away/presentation/Screens/orders/my_orders.dart';
import 'package:run_away/presentation/Screens/profile/my_profile.dart';
import 'package:run_away/presentation/Screens/wishlist/my_wishlists.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int indexPage = 2;
  final anController = ZoomDrawerController();
  // final screens = [
  //   const Categories(),
  //   MyWishlist(),
  //   HomePage(zoomController: anController),
  //   MyOrders(),
  //   ProfileScreen(),
  // ];

  final List<Icon> itemList = [
    const Icon(CupertinoIcons.square_grid_2x2),
    const Icon(CupertinoIcons.heart),
    const Icon(CupertinoIcons.house_fill),
    const Icon(CupertinoIcons.bag),
    const Icon(CupertinoIcons.person),
  ];

  @override
  Widget build(BuildContext context) {
    final screens = [
    const Categories(),
    MyWishlist(),
    HomePage(),
    MyOrders(),
    ProfileScreen(),
  ];
    final kHeight = MediaQuery.sizeOf(context);
    return Scaffold(
      
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: kLightBlue,
        height: kHeight.height * 0.075,
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
