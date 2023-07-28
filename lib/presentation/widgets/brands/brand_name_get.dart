
import 'package:flutter/material.dart';
import 'package:run_away/infrastructure/home_page/brand_fetch.dart';

class BrandNameStream extends StatelessWidget {
  const BrandNameStream({
    super.key,
    required this.popularPros,
    required this.anStyle,
  });

  final  popularPros;
  final TextStyle anStyle;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: anbrandFetch
          .doc(popularPros["brandId"])
          .snapshots(),
      builder: (context,AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Text("${snapshot.data!['brandName']}".toUpperCase(),style: anStyle,);
        } else {
          return const Text("Loading");
        }
      },
    );
  }
}