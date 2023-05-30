
import 'package:flutter/material.dart';

const kSpace50 = SizedBox(
  height: 50,
);

void snackBar(BuildContext context, String aText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        aText,
      ),
    ),
  );
}
