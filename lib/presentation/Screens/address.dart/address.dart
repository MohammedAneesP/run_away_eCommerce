import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';

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
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text('Contact Information', style: kHeadingMedText),
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
                    const DropdownButtonExample(anAddress: list)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Flutter code sample for [DropdownButton].

const List<String> list = <String>[
  'Pandarathil house P.O.orumanayoor',
  'Two',
  'Three',
  'Four'
];

class DropdownButtonExample extends StatefulWidget {
  final List<String> anAddress;
  const DropdownButtonExample({super.key, required this.anAddress});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          index = widget.anAddress.indexWhere((element) {
            return element == value;
          });
          log(value);
          log(index.toString());
        });
      },
      items: widget.anAddress.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            height: 30,
             color: kBlue,
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
