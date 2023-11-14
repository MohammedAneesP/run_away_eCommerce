import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/application/profile/profile_display/profile_displaying_bloc.dart';
import 'package:run_away/application/profile/profile_image_adding/profile_image_adding_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';

class AddingProfile extends StatelessWidget {
  AddingProfile({super.key});

  final fireName = FirebaseAuth.instance.currentUser;
  TextEditingController anFullNameController = TextEditingController();
  TextEditingController anNickNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    
    final theHeight = MediaQuery.of(context).size.height;
    double headMedSize = theHeight < 750 ? 13 : 17;
    final buttontextWhite = GoogleFonts.inter(
        fontSize: headMedSize, fontWeight: FontWeight.normal, color: kWhite);
        
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const EditProfileAppBar(anTitleText: "Add Profile"),
            SliverToBoxAdapter(
              child:
                  BlocBuilder<ProfileImageAddingBloc, ProfileImageAddingState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                                      "Camera",
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
                                    height: kHeight.height * 0.26,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kWhite,
                                      image: DecorationImage(
                                        image: state.anImage == null
                                            ? const AssetImage(
                                                "assets/user_3024605.png")
                                            : FileImage(
                                                File(
                                                  state.anImage!.path,
                                                ),
                                              ) as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 10,
                                    left: 200,
                                    child: Icon(
                                      CupertinoIcons.camera_fill,
                                      color: kBlue,
                                      size: 45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: kHeight.height * 0.04),
                          AddProfileText(
                              anLabelText: "Full name",
                              forMaxLine: 1,
                              anController: anFullNameController,
                              anType: TextInputType.name,
                              anValidateText: "this field required"),
                          SizedBox(height: kHeight.height * 0.04),
                          AddProfileText(
                              anLabelText: "Nickname",
                              forMaxLine: 1,
                              anController: anNickNameController,
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
                                BlocProvider.of<ProfileDisplayingBloc>(context)
                                    .add(AddingDetails(
                                        anEmail: fireName!.email.toString(),
                                        anFullName: anFullNameController.text,
                                        anNickName: anNickNameController.text,
                                        anImagePath: state.anImage!));
                                BlocProvider.of<ProfileImageAddingBloc>(context)
                                    .add(ClearImage());
                                BlocProvider.of<ProfileDisplayingBloc>(context)
                                    .add(GetProfile(
                                        anEmail: fireName!.email.toString()));
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }

                                log("Success");
                              } else {
                                log("failed");
                              }
                            },
                            style:
                                editProfileSubmitButtonStyle(kWidth, kHeight),
                            child: Text(
                              "Submit",
                              style: buttontextWhite,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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

class EditProfileAppBar extends StatelessWidget {
  final String anTitleText;
  const EditProfileAppBar({
    required this.anTitleText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      leading: const EditProfileAppLeading(),
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

class AddProfileText extends StatelessWidget {
  const AddProfileText(
      {super.key,
      required this.anLabelText,
      required this.forMaxLine,
      required this.anController,
      required this.anType,
      required this.anValidateText});
  final String anLabelText;
  final int? forMaxLine;
  final TextInputType anType;
  final String anValidateText;
  final TextEditingController anController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return anValidateText;
        } else {
          return null;
        }
      },
      controller: anController,
      textAlign: TextAlign.start,
      autocorrect: true,
      autofillHints: Characters.empty,
      maxLines: forMaxLine,
      keyboardType: anType,
      decoration: InputDecoration(
        filled: true,
        fillColor: kWhite,
        labelText: anLabelText,
        disabledBorder: InputBorder.none,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
        ),
      ),
    );
  }
}
