
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';

import 'drawer_menupage.dart';

class ForZoom extends StatelessWidget {
  const ForZoom({super.key}); 
  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      borderRadius: 45,
      menuBackgroundColor: kBlack,
      menuScreen: MenuPage(),
      mainScreen: BottomNavPage(),
    );
  }
}