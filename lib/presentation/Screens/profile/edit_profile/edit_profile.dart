import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/profile/profile_display/profile_displaying_bloc.dart';
import 'package:run_away/application/profile/profile_image_adding/profile_image_adding_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/profile/add_profile/add_profile.dart';

class EditProfileScreen extends StatelessWidget {
  final String anImage;
  final String anName;
  final String anNickName;
  EditProfileScreen({
    super.key,
    required this.anImage,
    required this.anName,
    required this.anNickName,
  });

  final fireName = FirebaseAuth.instance.currentUser;
  TextEditingController fullname = TextEditingController();
  TextEditingController nickname = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    fullname.text = anName;
    nickname.text = anNickName;
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: BlocBuilder<ProfileImageAddingBloc, ProfileImageAddingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const EditProfileAppLeading(),
              elevation: 0.0,
              title: Text(
                "Edit Profile",
                style: loginTitle,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: kHeight.height * 0.3,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: kTransparent,
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: kHeight.height * 0.15,
                                  decoration: BoxDecoration(
                                      color: kGrey200,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Row(
                                    children: [
                                      BlocProvider(
                                        create: (context) =>
                                            ProfileImageAddingBloc(),
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<
                                                        ProfileImageAddingBloc>(
                                                    context)
                                                .add(FromGallery());
                                            Navigator.pop(context);
                                          },
                                          splashColor: kBlue,
                                          child: SizedBox(
                                            width: kWidth.width * 0.497,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.photo,
                                                  size: 40,
                                                ),
                                                Text(
                                                  "Gallery",
                                                  style: kHeadingMedText,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      BlocProvider(
                                        create: (context) =>
                                            ProfileImageAddingBloc(),
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<
                                                        ProfileImageAddingBloc>(
                                                    context)
                                                .add(FromCamera());
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            width: kWidth.width * 0.497,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons
                                                      .photo_camera_solid,
                                                  size: 35,
                                                ),
                                                Text(
                                                  "Gallery",
                                                  style: kHeadingMedText,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: kHeight.height * 0.25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kWhite,
                                  image: state.anImage == null
                                      ? DecorationImage(
                                          image: NetworkImage(anImage),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          image: FileImage(
                                              File(state.anImage!.path)),
                                        ),
                                ),
                              ),
                              const Positioned(
                                bottom: 20,
                                left: 170,
                                child: Icon(
                                  CupertinoIcons.camera_circle,
                                  color: kBlue,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: kHeight.height * 0.04),
                      AddProfileText(
                          anLabelText: "Fullname",
                          forMaxLine: 1,
                          anController: fullname,
                          anType: TextInputType.name,
                          anValidateText: "this field required"),
                      SizedBox(height: kHeight.height * 0.04),
                      AddProfileText(
                          anLabelText: "Nickname",
                          forMaxLine: 1,
                          anController: nickname,
                          anType: TextInputType.name,
                          anValidateText: "this field required"),
                      SizedBox(height: kHeight.height * 0.03),
                      ElevatedButton(
                        onPressed: () async {
                          if (state.anImage == null) {
                            anSnackBarFunc(
                                context: context,
                                aText: "Please select an Image",
                                anColor: kRed);
                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            showCircleProgress(context);
                            BlocProvider.of<ProfileDisplayingBloc>(context).add(
                                AddingDetails(
                                    anEmail: fireName!.email.toString(),
                                    anFullName: fullname.text,
                                    anNickName: nickname.text,
                                    anImagePath: state.anImage!));
                            BlocProvider.of<ProfileImageAddingBloc>(context)
                                .add(ClearImage());
                            BlocProvider.of<ProfileDisplayingBloc>(context).add(
                                GetProfile(
                                    anEmail: fireName!.email.toString()));
                            await Future.delayed(const Duration(seconds: 2));
                            if (context.mounted) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          }
                        },
                        style: editProfileSubmitButtonStyle(kWidth, kHeight),
                        child: Text(
                          "Submit",
                          style: buttontextWhite,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

ButtonStyle editProfileSubmitButtonStyle(Size kWidth, Size kHeight) {
  return ButtonStyle(
      minimumSize: MaterialStatePropertyAll(
          Size(kWidth.width * 0.4, kHeight.height * 0.06)),
      backgroundColor: const MaterialStatePropertyAll(kBlue),
      shape: const MaterialStatePropertyAll(StadiumBorder()));
}


class EditProfileAppLeading extends StatelessWidget {
  const EditProfileAppLeading({
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
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: kBlack,
          ),
        ),
      ),
    );
  }
}
