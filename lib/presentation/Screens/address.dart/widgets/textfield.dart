import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';

class TheTextField extends StatelessWidget {
  const TheTextField({
    super.key,
    required this.anLabelText,
    required this.forMaxLine,
    required this.anController,
    required this.anType,
    required this.anValidateText
    
  });
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
      maxLines: forMaxLine,
      keyboardType: anType,
      decoration: InputDecoration(
        filled: true,
        fillColor: kGrey.withOpacity(0.1),
        label: Text(anLabelText),
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
