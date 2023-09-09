import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/address.dart/addres_adding.dart';
import 'package:run_away/presentation/Screens/cart/widgets/cart_product_img.dart';

int anAddressIndex = 0;

class AddressSelecting extends StatefulWidget {
  const AddressSelecting({super.key});

  @override
  State<AddressSelecting> createState() => _AddressSelectingState();
}

class _AddressSelectingState extends State<AddressSelecting> {
  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
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
                    const AddressDropDown(anAddress: list),
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
                  Text("₹ 25000", style: kTitleNonBoldText)
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping", style: kNonboldTitleText),
                  Text("₹ 00", style: kTitleNonBoldText)
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Cost", style: kTitleNonBoldText),
                  Text("₹ 25000", style: kTitleText)
                ],
              ),
              SizedBox(height: kHeight.height * 0.01),
              ElevatedButton(
                  style: checkOutButtonStyle(kWidth, kHeight),
                  onPressed: () {
                    
                  },
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

/// Flutter code sample for [DropdownButton].

const List<String> list = <String>[
  'Pandarathil house P.O.orumanayoor piloksuovsoihibiybyib',
  'Two',
  'Three',
  'Four'
];

class AddressDropDown extends StatefulWidget {
  final List<String> anAddress;

  const AddressDropDown({super.key, required this.anAddress});

  @override
  State<AddressDropDown> createState() => _AddressDropDownState();
}

class _AddressDropDownState extends State<AddressDropDown> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: const Divider(color: kTransparent),
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      elevation: 16,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          anAddressIndex = widget.anAddress.indexWhere((element) {
            return element == value;
          });
          log(value);
          log(anAddressIndex.toString());
        });
      },
      items: widget.anAddress.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: SizedBox(
            height: 30,
            width: 300,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }
}
