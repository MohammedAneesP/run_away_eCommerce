import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/address/address_dropdown/dropdown_address_bloc.dart';
import 'package:run_away/application/address/address_edit/address_edit_bloc.dart';
import 'package:run_away/application/address/address_view/address_view_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/address.dart/widgets/textfield.dart';

class EditAddress extends StatelessWidget {
  final String anMapKey;
  EditAddress({
    super.key,
    required this.anMapKey,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final fireName = FirebaseAuth.instance.currentUser;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddressEditBloc>(context).add(EditingAddress(
        anEmail: fireName!.email.toString(), anMapKey: anMapKey));
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);

    return BlocBuilder<AddressEditBloc, AddressEditState>(
      builder: (context, state) {
        if (state.theAddresses.isEmpty) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final address = state.theAddresses;
          nameController.text = address["name"].toString();
          emailController.text = address["email"].toString();
          numberController.text = address["number"].toString();
          placeController.text = address["place"].toString();
          addressController.text = address["address"].toString();
          landMarkController.text = address["landmark"].toString();
          pincodeController.text = address["pincode"].toString();

          return Scaffold(
            appBar: AppBar(
              title: Text("Edit Address", style: kTitleText),
              centerTitle: true,
              surfaceTintColor: kTransparent,
              backgroundColor: kGrey200,
              shadowColor: kTransparent,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: kWhite,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Name', style: kHeadingMedText),
                      SizedBox(height: kHeight.height * 0.01),
                      TheTextField(
                          anValidateText: "enter a Name",
                          anLabelText: "enter name",
                          forMaxLine: 1,
                          anController: nameController,
                          anType: TextInputType.name),
                      SizedBox(height: kHeight.height * 0.01),
                      Text('Email address', style: kHeadingMedText),
                      SizedBox(height: kHeight.height * 0.01),
                      TextFormField(
                        validator: (value) {
                          final emailRegExp =
                              RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          } else if (!emailRegExp.hasMatch(value)) {
                            return 'Invalid email address';
                          } else {
                            return null;
                          }
                        },
                        controller: emailController,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kGrey.withOpacity(0.1),
                          hintText: "email address",
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
                      ),
                      SizedBox(height: kHeight.height * 0.01),
                      Text('Your Place', style: kHeadingMedText),
                      TheTextField(
                          anValidateText: "please enter the Place",
                          anLabelText: "Enter your Place here",
                          forMaxLine: 2,
                          anController: placeController,
                          anType: TextInputType.name),
                      SizedBox(height: kHeight.height * 0.01),
                      Text('Address', style: kHeadingMedText),
                      SizedBox(height: kHeight.height * 0.01),
                      TheTextField(
                          anValidateText: "please enter the address",
                          anLabelText: "Enter your Address here",
                          forMaxLine: 3,
                          anController: addressController,
                          anType: TextInputType.name),
                      SizedBox(height: kHeight.height * 0.01),
                      Text('Landmark', style: kHeadingMedText),
                      SizedBox(height: kHeight.height * 0.01),
                      TheTextField(
                          anValidateText: "enter an landmark",
                          anLabelText: "@eg. near mission hospital",
                          forMaxLine: 2,
                          anController: landMarkController,
                          anType: TextInputType.name),
                      SizedBox(height: kHeight.height * 0.01),
                      Text('Pincode', style: kHeadingMedText),
                      SizedBox(height: kHeight.height * 0.01),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your Pincode";
                          } else if (value.length != 6) {
                            return "please enter a Valid Pincode";
                          } else {
                            return null;
                          }
                        },
                        controller: pincodeController,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kGrey.withOpacity(0.1),
                          hintText: "pincode",
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
                      ),
                      SizedBox(height: kHeight.height * 0.01),
                      Text('Contact Number', style: kHeadingMedText),
                      SizedBox(height: kHeight.height * 0.01),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your Number";
                          } else if (value.length != 10) {
                            return "please enter a Valid Number";
                          } else {
                            return null;
                          }
                        },
                        controller: numberController,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kGrey.withOpacity(0.1),
                          hintText: "Mobile Number",
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
                      ),
                      SizedBox(height: kHeight.height * 0.04),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    const MaterialStatePropertyAll(kBlue),
                                shape: const MaterialStatePropertyAll(
                                    StadiumBorder()),
                                fixedSize: MaterialStatePropertyAll(Size(
                                    kWidth.width * .5, kHeight.height * 0.07))),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const CircularProgressIndicator());
                                BlocProvider.of<AddressEditBloc>(context)
                                    .add(UpdatingAddress(
                                  anEmail: fireName!.email.toString(),
                                  userEmail: emailController.text,
                                  place: placeController.text,
                                  address: addressController.text,
                                  landmark: landMarkController.text,
                                  name: nameController.text,
                                  number: numberController.text,
                                  pincode: pincodeController.text,
                                  anMapkey: address["keyValue"].toString(),
                                  editAddressKey: anMapKey.toString(),
                                ));
                                BlocProvider.of<DropDownAddressBloc>(context)
                                    .add(AddressChanging(
                                        address: anMapKey.toString()));
                                BlocProvider.of<AddressViewBloc>(context).add(
                                    ViewingAddresses(
                                        anEmail: fireName!.email.toString()));
                                snackBar(
                                    context, "Address successfully Updated👏");
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } else {
                                log("empty fields");
                              }
                            },
                            child: Text(
                              "Update Address",
                              style: buttontextWhite,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
