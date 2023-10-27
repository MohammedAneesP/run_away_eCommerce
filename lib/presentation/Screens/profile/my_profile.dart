import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:run_away/application/profile/profile_display/profile_displaying_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';
import 'package:run_away/presentation/Screens/profile/add_profile/add_profile.dart';
import 'package:run_away/presentation/Screens/profile/edit_profile/edit_profile.dart';
import 'package:run_away/presentation/Screens/wishlist/widgets/appbar_widgets/leading_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final fireName = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ProfileDisplayingBloc>(context)
          .add(GetProfile(anEmail: fireName!.email.toString()));
    });
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavPage(),
          ),
        );
        return true;
      },
      child: BlocBuilder<ProfileDisplayingBloc, ProfileDisplayingState>(
        builder: (context, state) {
          if (state.anProfile.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text("Profile", style: kTitleText),
                leading: const AppbarLeading(),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: kHeight.height * 0.35,
                        child: LottieBuilder.asset(
                          "assets/animation_lnpkse54.json",
                          height: kHeight.height * 0.2,
                          width: kWidth.width * 1,
                        ),
                      ),
                      const Text("You haven't added any details"),
                      SizedBox(height: kHeight.height * 0.01),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddingProfile(),
                              ));
                        },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(kBlue),
                            shape: MaterialStatePropertyAll(StadiumBorder())),
                        child: Text(
                          "Add profile",
                          style: buttontextWhite,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            final anProfile = state.anProfile;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text("Profile", style: kTitleText),
                leading: const AppbarLeading(),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                anImage: anProfile["image"],
                                anName: anProfile["fullname"],
                                anNickName: anProfile["nickname"],
                              ),
                            ));
                      },
                      icon: const Icon(
                        Icons.border_color_sharp,
                        color: kBlue,
                      ))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: kHeight.height * 0.3,
                      child: Container(
                        height: kHeight.height * 0.3,
                        decoration: state.anProfile["image"] == null
                            ? const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kWhite,
                                image: DecorationImage(
                                  image: AssetImage("assets/user_3024605.png"),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : BoxDecoration(
                                shape: BoxShape.circle,
                                color: kWhite,
                                image: DecorationImage(
                                  image: NetworkImage(state.anProfile["image"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: kHeight.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 270, 0),
                      child: Text(
                        "Full Name",
                        style: kHeadingText,
                      ),
                    ),
                    SizedBox(height: kHeight.height * 0.01),
                    Container(
                      height: kHeight.height * 0.07,
                      width: kWidth.width,
                      decoration: const BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 22, 0, 0),
                        child:
                            Text(anProfile["fullname"], style: kSubTitleText),
                      ),
                    ),
                    SizedBox(height: kHeight.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 270, 0),
                      child: Text(
                        "NickName",
                        style: kHeadingText,
                      ),
                    ),
                    SizedBox(height: kHeight.height * 0.01),
                    Container(
                      height: kHeight.height * 0.07,
                      width: kWidth.width,
                      decoration: const BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 22, 0, 0),
                        child:
                            Text(anProfile["nickname"], style: kSubTitleText),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class MainAppBars extends StatelessWidget {
  final String anTitleText;
  final VoidCallback anOnpressed;
  const MainAppBars({
    required this.anOnpressed,
    required this.anTitleText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      leading: const AppbarLeading(),
      actions: [
        IconButton(
            onPressed: anOnpressed,
            icon: const Icon(
              Icons.border_color_outlined,
              color: kBlue,
            ))
      ],
      pinned: false,
      floating: true,
      elevation: 0.0,
      title: Text(
        anTitleText,
        style: loginTitle,
      ),
    );
  }
}
