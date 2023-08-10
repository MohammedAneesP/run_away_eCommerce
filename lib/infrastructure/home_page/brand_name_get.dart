
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BrandNameStream extends StatelessWidget {
   BrandNameStream({
    super.key,
    required this.popularPros,
    required this.anStyle,
  });

  final dynamic popularPros;
  final TextStyle anStyle;

  final anbrandFetch =  FirebaseFirestore.instance.collection("brands");

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