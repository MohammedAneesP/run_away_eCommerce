
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/presentation/Screens/address.dart/address.dart';
import 'package:run_away/presentation/Screens/address.dart/editing_address/edit_address.dart';

class EmailPhoneTileEdit extends StatelessWidget {
  const EmailPhoneTileEdit(
      {super.key,
      required this.emailNotify,
      required this.theAddress,
      required this.anKeyForMap,
      required this.anSubTitleText,
      required this.anIcon});

  final ValueNotifier<String> emailNotify;
  final Map<String, dynamic> theAddress;
  final String anKeyForMap;
  final String anSubTitleText;
  final Icon anIcon;

  @override
  Widget build(BuildContext context) {
    final theHeight = MediaQuery.of(context).size.height;
    double theSize = theHeight <750?12:15;
    return ListTile(
      
      leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: kGrey200,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: anIcon),
      title: ValueListenableBuilder(
        valueListenable: emailNotify,
        builder: (context, value, child) {
          emailNotify.value = theAddress[anSelectedAddress][anKeyForMap];
          return Text(
            emailNotify.value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: theSize),
          );
        },
      ),
      subtitle: Text(anSubTitleText),
      trailing: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAddress(
                    anMapKey: anSelectedAddress,
                  ),
                ));
          },
          icon: const Icon(Icons.border_color_rounded)),
    );
  }
}