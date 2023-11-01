import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/profile/profile_display/profile_displaying_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/presentation/Screens/cart/my_cart.dart';
import 'package:run_away/presentation/Screens/home_page/zoom_drawer/zomm_drawer.dart';
import 'package:run_away/presentation/Screens/orders/my_orders.dart';
import 'package:run_away/presentation/Screens/profile/my_profile.dart';
import 'package:run_away/presentation/Screens/wishlist/my_wishlists.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenNames = [
      "Profile",
      "Home Page",
      "My Cart",
      "Wishlists",
      "Orders",
    ];
    final screenIcons = [
      const Icon(CupertinoIcons.person, color: kWhite),
      const Icon(CupertinoIcons.house, color: kWhite),
      const Icon(CupertinoIcons.cart, color: kWhite),
      const Icon(CupertinoIcons.heart, color: kWhite),
      const Icon(CupertinoIcons.bag, color: kWhite),
    ];
    final kHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<ProfileDisplayingBloc, ProfileDisplayingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kBlack,
          body: ListView(
            children: [
              DrawerHeader(
                child: state.anProfile.isEmpty
                    ? const CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.person,
                          size: 80,
                        ),
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(state.anProfile["image"]),
                      ), 
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                child: Text("Hey, 👋", style: kGreyItalicText),
              ),
              SizedBox(
                height: kHeight * .5,
                child: ListView.builder(
                  itemCount: screenNames.length,
                  itemBuilder: (context, index) {
                    final screens = [
                      ProfileScreen(),
                      const ForZoom(),
                      MyCart(),
                      MyWishlist(),
                      MyOrders(),
                    ];
                    return ListTile(
                      title: Text(
                        screenNames[index],
                        style: const TextStyle(color: kWhite),
                      ),
                      leading: screenIcons[index],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => screens[index],
                            ));
                      },
                    );
                  },
                ),
              ),
              const Divider(color: kWhite, indent: 10, endIndent: 10),
              ListTile(
                onTap: () {
                  FireBaseAuthMethods(FirebaseAuth.instance).signOut(context);
                },
                leading: const Icon(
                  Icons.logout,
                  color: kWhite,
                ),
                title: Text(
                  "Sign Out",
                  style: buttontextWhite,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
