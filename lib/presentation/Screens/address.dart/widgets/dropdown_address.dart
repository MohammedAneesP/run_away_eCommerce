import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class DropDownAddress extends StatelessWidget {
  final List<String> theAddress;
  final Map<String, dynamic> addressed;
  final ValueChanged<String?>? anOnChange;
  final String anOption;

 const DropDownAddress({
    super.key,
    required this.addressed,
    required this.theAddress,
    required this.anOnChange,
    required this.anOption,
  });

  @override
  Widget build(BuildContext context) {
    final theHeight = MediaQuery.of(context).size.height;
    double theSize = theHeight < 750 ? 12 : 15;

    return DropdownButton<String>(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      value: anOption,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      elevation: 16,
      onChanged: anOnChange,
      items: theAddress.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final name = capitalizeFirstLetter(addressed[value]["name"]);
              final address =
                  capitalizeFirstLetter(addressed[value]["address"]);
              final place = capitalizeFirstLetter(addressed[value]["place"]);
              return SizedBox(
                height: 50,
                width: 300,
                child: Text(
                  maxLines: 2,
                  "$name"
                  " $address"
                  " $place"
                  " ${addressed[value]["pincode"]}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: theSize),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
