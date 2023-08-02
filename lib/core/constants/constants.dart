
import 'package:flutter/material.dart';

const kSpace50 = SizedBox(
  height: 50,
);

void snackBar(BuildContext context, String aText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape:const StadiumBorder(),
      content: Center(
        child: Text(
          aText,
        ),
      ),
    ),
  );
}


