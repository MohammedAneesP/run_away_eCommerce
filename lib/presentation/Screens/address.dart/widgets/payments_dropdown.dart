import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';

class PaymentDropDown extends StatelessWidget {
  final List<String> theAddress;
  final ValueChanged<String?>? anOnChange;
  final String anOption;

  const PaymentDropDown({
    super.key,
    required this.theAddress,
    required this.anOnChange,
    required this.anOption,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.height;
    double theSize = screenSize < 750 ? 12 : 15;
    final kSubTitleText = GoogleFonts.roboto(
        fontWeight: FontWeight.w500, fontSize: theSize, color: kBlack);
    return DropdownButton<String>(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      value: anOption,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      elevation: 16,
      padding:  EdgeInsets.fromLTRB(0, 0, 0, theSize),
      underline: const Divider(
        color: kTransparent,
      ),
      onChanged: anOnChange,
      items: theAddress.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          alignment: Alignment.center,
          child: Container(
            height: 40,
            width: 280,
            decoration: BoxDecoration(
              border: Border.all(
                color: kBlack,
                strokeAlign: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
                child: Text(
              value,
              style: kSubTitleText,
            )),
          ),
        );
      }).toList(),
    );
  }
}
