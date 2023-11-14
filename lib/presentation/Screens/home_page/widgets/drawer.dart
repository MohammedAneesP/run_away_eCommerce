
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/profile/profile_display/profile_displaying_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';
import 'package:run_away/presentation/Screens/cart/my_cart.dart';
import 'package:run_away/presentation/Screens/login_sign_up_pages/login_page.dart';
import 'package:run_away/presentation/Screens/orders/my_orders.dart';
import 'package:run_away/presentation/Screens/profile/add_profile/add_profile.dart';
import 'package:run_away/presentation/Screens/profile/my_profile.dart';
import 'package:run_away/presentation/Screens/wishlist/my_wishlists.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer(
      {super.key,
      required this.kHeight,
      required this.kWidth,
      required this.anName,
      required this.screenNames,
      required this.screenIcons});

  final double kHeight;
  final double kWidth;
  final String anName;
  final List<Icon> screenIcons;
  final List<String> screenNames;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: kWidth * 0.6,
      backgroundColor: kGrey200,
      child: BlocBuilder<ProfileDisplayingBloc, ProfileDisplayingState>(
        builder: (context, state) {
          return ListView(
            children: [
              DrawerHeader(
                child: state.anProfile.isEmpty
                    ? InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddingProfile(),
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.person_add_alt_1,
                            size: 80,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(state.anProfile["image"]),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                child: state.anProfile.isEmpty
                    ? Text("Hey, 👋 $anName", style: kGreyItalicText)
                    : Text("Hey, 👋 ${state.anProfile["fullname"]}",
                        style: kGreyItalicText),
              ),
              SizedBox(
                height: kHeight * .4,
                child: ListView.builder(
                  itemCount: screenNames.length,
                  itemBuilder: (context, index) {
                    final screens = [
                      ProfileScreen(),
                      const BottomNavPage(),
                      MyCart(),
                      MyWishlist(),
                      MyOrders(),
                    ];
                    return ListTile(
                      leading: screenIcons[index],
                      title: Text(screenNames[index]),
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
              Column(
                children: [
                  const Divider(indent: 10, endIndent: 10),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Sign Out"),
                    onTap: () {
                      FireBaseAuthMethods(FirebaseAuth.instance)
                          .signOut(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
