
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/address.dart/adding_address/addres_adding.dart';
import 'package:run_away/presentation/Screens/address.dart/widgets/textfield.dart';

class NoAddressAddedTile extends StatelessWidget {
  const NoAddressAddedTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}