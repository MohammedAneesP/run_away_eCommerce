import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/address/address_view/address_view_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/address.dart/adding_address/addres_adding.dart';
import 'package:run_away/presentation/Screens/cart/widgets/cart_product_img.dart';

int anAddressIndex = 0;

class AddressSelecting extends StatefulWidget {
  const AddressSelecting({super.key});

  @override
  State<AddressSelecting> createState() => _AddressSelectingState();
}

class _AddressSelectingState extends State<AddressSelecting> {
  final fireName = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddressViewBloc>(context)
        .add(ViewingAddresses(anEmail: fireName!.email.toString()));
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return BlocBuilder<AddressViewBloc, AddressViewState>(
      builder: (context, state) {
        if (state.products.isEmpty) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (state.addresses.isEmpty) {
            int subtotal = 0;
            int shipping = 0;
            int totalCost = 0;
            for (var i = 0; i < state.products.length; i++) {
              final productId = state.products[i]["productId"].toString();
              final countParse = int.parse(state.cart[productId]["count"]);
              final priceParsing = int.parse(state.cart[productId]["price"]);
              subtotal = subtotal + (priceParsing * countParse);
            }
            if (subtotal >= 20000) {
              shipping = 0;
            } else {
              shipping = 150;
            }
            totalCost = shipping + subtotal;
            return Scaffold(
              appBar: AppBar(
                title: Text("CHECKOUT", style: kTitleText),
                centerTitle: true,
                surfaceTintColor: kTransparent,
                backgroundColor: kGrey200,
                shadowColor: kTransparent,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: roundRectanglrShape(),
                  tileColor: kWhite,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddingAddress(),
                  )),
                  title: Text(
                    "Press here to Add Address",
                    style: kSubTitleText,
                  ),
                  trailing: const Icon(Icons.arrow_right_sharp),
                ),
              ),
              bottomSheet: Container(
                height: kHeight.height * 0.23,
                color: kWhite,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: kHeight.height * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal", style: kNonboldTitleText),
                          Text('$subtotal', style: kTitleNonBoldText)
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Shipping", style: kNonboldTitleText),
                          Text("₹ $shipping", style: kTitleNonBoldText)
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Cost", style: kTitleNonBoldText),
                          Text("₹ $totalCost", style: kTitleText)
                        ],
                      ),
                      SizedBox(height: kHeight.height * 0.01),
                      ElevatedButton(
                          style: checkOutButtonStyle(kWidth, kHeight),
                          onPressed: () {},
                          child: Text(
                            "Continue to Pay",
                            style: buttontextWhite,
                          ))
                    ],
                  ),
                ),
              ),
            );
          } else {
            List<String> addressIds = [];
            state.addresses.forEach((key, value) {
              addressIds.add(key);
            });
            String selectedAddress = addressIds.first;
            log(addressIds.toString());
            int subtotal = 0;
            int shipping = 150;
            int totalCost = 0;
            for (var i = 0; i < state.products.length; i++) {
              final productId = state.products[i]["productId"].toString();
              final countParse = int.parse(state.cart[productId]["count"]);
              final priceParsing = int.parse(state.cart[productId]["price"]);
              subtotal = subtotal + (priceParsing * countParse);
            }
            if (subtotal >= 20000) {
              shipping = 0;
            } else {
              shipping = 150;
            }
            totalCost = subtotal + shipping;
            return Scaffold(
              appBar: AppBar(
                title: Text("CHECKOUT", style: kTitleText),
                centerTitle: true,
                surfaceTintColor: kTransparent,
                backgroundColor: kGrey200,
                shadowColor: kTransparent,
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: kHeight.height * .45,
                  width: kWidth.width,
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Contact Information', style: kHeadingMedText),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddingAddress(),
                                  ));
                                },
                                child: const Text("Add Address")),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: kGrey200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: const Icon(CupertinoIcons.envelope)),
                        title: const Text(
                          "mohammedAnees454@gmail.com",
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: const Text("Email"),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.border_color_rounded)),
                      ),
                      ListTile(
                        leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: kGrey200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: const Icon(CupertinoIcons.phone)),
                        title: const Text(
                          "9995663322",
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: const Text("Phone"),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.border_color_rounded)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address', style: kHeadingMedText),
                            DropdownButton<String>(
                              underline: const Divider(color: kTransparent),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              value: selectedAddress,
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              elevation: 16,
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  selectedAddress = value!;
                                  anAddressIndex =
                                      addressIds.indexWhere((element) {
                                    return element == value;
                                  });
                                  log(value);
                                  log(anAddressIndex.toString());
                                });
                              },
                              items: addressIds.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) => SizedBox(
                                      height: 50,
                                      width: 300,
                                      child: Text(
                                        maxLines: 2,
                                        "${state.addresses[selectedAddress]}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Text('Payment Method', style: kHeadingMedText),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomSheet: Container(
                height: kHeight.height * 0.23,
                color: kWhite,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: kHeight.height * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal", style: kNonboldTitleText),
                          Text('$subtotal', style: kTitleNonBoldText)
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Shipping", style: kNonboldTitleText),
                          Text("₹ $shipping", style: kTitleNonBoldText)
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Cost", style: kTitleNonBoldText),
                          Text("₹ $totalCost", style: kTitleText)
                        ],
                      ),
                      SizedBox(height: kHeight.height * 0.01),
                      ElevatedButton(
                          style: checkOutButtonStyle(kWidth, kHeight),
                          onPressed: () {},
                          child: Text(
                            "Continue to Pay",
                            style: buttontextWhite,
                          ))
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}

RoundedRectangleBorder roundRectanglrShape() =>
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)));
