
import 'package:flutter/material.dart';

class TheTextFormField extends StatelessWidget {
  const TheTextFormField({
    super.key,
    required this.anController,
    required this.returnText,
    required this.anLabelText,
    required this.isObscure,
    required this.anPrefixIcon,
    this.anSuffixIcon,
    required this.keyInputType
  });

  final TextEditingController anController;
  final String returnText;
  final String anLabelText;
  final bool isObscure;
  final Icon anPrefixIcon;
  final anSuffixIcon;
  final TextInputType keyInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return returnText;
        }
        return null;
      },
      keyboardType: keyInputType,
      controller: anController,
      cursorColor: Colors.black,
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: anPrefixIcon,
        suffixIcon: anSuffixIcon,
        labelText: anLabelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
