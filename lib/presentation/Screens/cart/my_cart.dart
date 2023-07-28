
import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Cart",style: kHeadingText,),),
    );
  }
}