import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/presentation/login_sign_up_pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final userName = FireBaseAuthMethods(FirebaseAuth.instance);
  final fireName = FirebaseAuth.instance.currentUser;

  final List<dynamic> carouselImages = [
    "assets/landing_pic_1.png",
    "assets/landing_pic_2.png",
    "assets/landing_pic_3.png",
  ];

  final List<dynamic> textProducts = [
    "nike air",
    "adidas beats",
    "puma wilder"
  ];

  final List<dynamic> textPrice = [
    " ₹. 3500",
    " ₹. 6000",
    " ₹. 7000",
  ];

  final brandCollection = FirebaseFirestore.instance.collection("brands");

  bool isSelected = false;

  List<dynamic> getId = [];

  final gettingProId = [];

  int? _selectedindex;

  Future<void> fetchingProducts() async {
    final brandCollection =
        await FirebaseFirestore.instance.collection("brands").get();
    for (var everyBrand in brandCollection.docs) {
      final productSnapshot =
          await everyBrand.reference.collection("shoe").get();
      for (var productDoc in productSnapshot.docs) {
        final productData = productDoc.data();
        log(productData.toString());
        gettingProId.add(productData);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchingProducts();
  }

  ValueNotifier<int> anSelectVal = ValueNotifier(0);

  void changeValue(int anItem) {
    anSelectVal.value = ValueNotifier(anItem).value;
  }

  @override
  Widget build(BuildContext context) {
    // log(gettingProId.toString());
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    // log(fireName!.displayName.toString());
    var sizedBoxGap = SizedBox(height: kHeight * 0.05);
    return Scaffold(
      backgroundColor: kGrey.withOpacity(0.05),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        //surfaceTintColor: Colors.transparent,
        backgroundColor: kWhite.withOpacity(0),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.square_grid_2x2_fill,
            size: 30,
          ),
        ),
        title: Text("RunAway", style: textMainTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kWhite.withOpacity(0.4),
              radius: 30,
              child: IconButton(
                onPressed: () {
                  FireBaseAuthMethods(FirebaseAuth.instance).signOut(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 25,
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: kHeight * 0.02,
                ),
                CupertinoSearchTextField(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  backgroundColor: kWhite.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                SizedBox(height: kHeight * 0.01),
                SizedBox(height: kHeight * 0.02),
                StreamBuilder(
                  stream: brandCollection.orderBy("brandName").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: kHeight * 0.07,
                            width: kWidth,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) => SizedBox(
                                width: kWidth * 0.05,
                              ),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final refName = snapshot.data!.docs[index];
                                getId.add(refName["brandId"]);
                                // log(getId.toString());
                                return ValueListenableBuilder(
                                  valueListenable: anSelectVal,
                                  builder: (context, value, _){
                                    return ChoiceChip(
                                    backgroundColor: Colors.transparent,
                                    selectedColor: Colors.lightBlue,
                                    selected: anSelectVal.value == index,
                                
                                    onSelected: (value) {
                                      changeValue(index);
                                      log(anSelectVal.value.toString());
                                     // setState(() {});
                                    },
                                    labelPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    avatar: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                refName["imageName"])),
                                      ),
                                    ),
                                    label: anSelectVal.value == index
                                        ? ValueListenableBuilder(
                                            valueListenable: anSelectVal,
                                            builder: (BuildContext context, value,
                                                    _) =>
                                                Text(
                                              "${refName["brandName"]}"
                                                  .toUpperCase(),
                                            ),
                                          )
                                        : ValueListenableBuilder(
                                            valueListenable: anSelectVal,
                                            builder: (context, value, child) =>
                                                const Text(""),
                                          ),
                                    //  _selectedindex == index
                                    //     ? Text("${refName["brandName"]}"
                                    //         .toUpperCase())
                                    //     : const Text(''),
                                    shape: const StadiumBorder(),
                                    side: BorderSide.none,
                                  );
                                  } ,
                                  // child: ChoiceChip(
                                  //   backgroundColor: Colors.transparent,
                                  //   selectedColor: Colors.lightBlue,
                                  //   selected: anSelectVal.value == index,
                                
                                  //   onSelected: (value) {
                                  //     changeValue(index);
                                  //     log(anSelectVal.value.toString());
                                  //    // setState(() {});
                                  //   },
                                  //   labelPadding: const EdgeInsets.symmetric(
                                  //       horizontal: 8, vertical: 8),
                                  //   avatar: Container(
                                  //     height: 40,
                                  //     width: 40,
                                  //     decoration: BoxDecoration(
                                  //       color: kWhite,
                                  //       shape: BoxShape.circle,
                                  //       image: DecorationImage(
                                  //           image: NetworkImage(
                                  //               refName["imageName"])),
                                  //     ),
                                  //   ),
                                  //   label: anSelectVal.value == index
                                  //       ? ValueListenableBuilder(
                                  //           valueListenable: anSelectVal,
                                  //           builder: (BuildContext context, value,
                                  //                   _) =>
                                  //               Text(
                                  //             "${refName["brandName"]}"
                                  //                 .toUpperCase(),
                                  //           ),
                                  //         )
                                  //       : ValueListenableBuilder(
                                  //           valueListenable: anSelectVal,
                                  //           builder: (context, value, child) =>
                                  //               const Text(""),
                                  //         ),
                                  //   //  _selectedindex == index
                                  //   //     ? Text("${refName["brandName"]}"
                                  //   //         .toUpperCase())
                                  //   //     : const Text(''),
                                  //   shape: const StadiumBorder(),
                                  //   side: BorderSide.none,
                                  // ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                SizedBox(height: kHeight * 0.025),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 220, 0),
                  child: Text(
                    "Popular pick's".toUpperCase(),
                    style: kHeadingMedText,
                  ),
                ),
                SizedBox(height: kHeight * 0.02),
                SizedBox(
                  height: kHeight * .25,
                  width: kWidth,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (context, index) => SizedBox(
                      width: kWidth * 0.05,
                    ),
                    itemBuilder: (context, index) => Container(
                      // height: kHeight * .001,
                      width: kWidth * .4,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: kHeight * .17,
                              decoration: BoxDecoration(
                                //   color: Colors.red,
                                image: DecorationImage(
                                    image: AssetImage(carouselImages[index]),
                                    fit: BoxFit.cover),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                            ),
                            Text("${textProducts[index]}".toUpperCase()),
                            Text(textPrice[index])
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBoxGap,
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 240, 0),
                  child: Text(
                    "New Arrivals",
                    style: kHeadingText,
                  ),
                ),
                sizedBoxGap,
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                sizedBoxGap,
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 247, 0),
                  child: Text(
                    "All products",
                    style: kHeadingText,
                  ),
                ),
                SizedBox(
                  height: kHeight * 0.03,
                ),
                SizedBox(
                  height: kHeight * 1.4,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                      childAspectRatio: 5,
                      mainAxisExtent: 230,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: kHeight * .17,
                                decoration: BoxDecoration(
                                  //   color: Colors.red,
                                  image: DecorationImage(
                                      image: AssetImage(carouselImages[2]),
                                      fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                              ),
                              Text("${textProducts[1]}".toUpperCase()),
                              Text(textPrice[2])
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



 // CarouselSlider(
   //   options: CarouselOptions(
   //       height: 200.0,
   //       autoPlay: true,
   //       enlargeCenterPage: true,
   //       viewportFraction: 1),
   //   items: carouselImages.map(
   //     (i) {
   //       return Builder(
   //         builder: (BuildContext context) {
   //           return Container(
   //margin:
   //    const EdgeInsets.symmetric(horizontal: 10.0),
   //decoration: BoxDecoration(
   //  borderRadius: BorderRadius.circular(25),
   //  color: kGrey.withOpacity(0.1),
   //  image: DecorationImage(
   //      image: AssetImage(i), fit: BoxFit.cover),
   //),
   //           );
   //         },
   //       );
   //     },
   //   ).toList(),
   // ),