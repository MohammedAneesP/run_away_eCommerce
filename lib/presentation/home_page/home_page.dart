import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/home_page/home_choice/brand_choice_bloc.dart';
import 'package:run_away/application/home_page/popular_picks/popular_product_bloc.dart';
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
    " ₹ 3500",
    " ₹ 6000",
    " ₹ 7000",
  ];

  final brandCollection = FirebaseFirestore.instance.collection("brands");

  bool isSelected = false;

  List<dynamic> getId = [];

  final gettingProId = [];

  // int? _selectedindex;

  Future<void> fetchingProducts() async {
    final brandCollection =
        await FirebaseFirestore.instance.collection("brands").get();
    for (var everyBrand in brandCollection.docs) {
      final productSnapshot =
          await everyBrand.reference.collection("shoe").get();
      for (var productDoc in productSnapshot.docs) {
        final productData = productDoc.data();
        //log(productData.toString());
        gettingProId.add(productData);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchingProducts();
  }

  ValueNotifier<int> anSelectVal = ValueNotifier(-1);

  void changeValue(int anItem) {
    anSelectVal.value = ValueNotifier(anItem).value;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BrandChoiceBloc>(context).add(DisplayBrand());
    BlocProvider.of<PopularProductBloc>(context).add(SomeProduct());
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    // log(fireName!.displayName.toString());
    var sizedBoxGap = SizedBox(height: kHeight * 0.05);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.grey[200],
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Container(
            height: kHeight * 0.001,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.square_grid_2x2_fill,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text("RunAway", style: textMainTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: CircleAvatar(
              backgroundColor: kWhite,
              radius: 30,
              child: IconButton(
                onPressed: () {
                  FireBaseAuthMethods(FirebaseAuth.instance).signOut(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: kHeight * 0.03),
              CupertinoSearchTextField(
                padding: const EdgeInsets.fromLTRB(17, 17, 17, 17),
                backgroundColor: kWhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              SizedBox(height: kHeight * 0.03),
              Column(
                children: [
                  SizedBox(
                    height: kHeight * 0.07,
                    width: kWidth,
                    child: BlocBuilder<BrandChoiceBloc, BrandChoiceState>(
                      builder: (context, state) {
                        if (state.theBrands.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(
                              width: kWidth * 0.05,
                            ),
                            itemCount: state.theBrands.length,
                            itemBuilder: (context, index) {
                              final refName = state.theBrands[index];
                              // getId.add(refName["brandId"]);
                              return ValueListenableBuilder(
                                valueListenable: anSelectVal,
                                builder: (context, value, _) {
                                  return ChoiceChip(
                                    backgroundColor: Colors.transparent,
                                    selectedColor: Colors.lightBlue,
                                    selected: anSelectVal.value == index,
                                    onSelected: (value) {
                                      changeValue(index);
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
                                            refName["imageName"],
                                          ),
                                        ),
                                      ),
                                    ),
                                    label: anSelectVal.value == index
                                        ? ValueListenableBuilder(
                                            valueListenable: anSelectVal,
                                            builder: (BuildContext context,
                                                    value, _) =>
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
                                    shape: const StadiumBorder(),
                                    side: BorderSide.none,
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
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
                child: BlocBuilder<PopularProductBloc, PopularProductState>(
                  builder: (context, state) {
                    if (state.theProducts.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.theProducts.length,
                        separatorBuilder: (context, index) => SizedBox(
                          width: kWidth * 0.05,
                        ),
                        itemBuilder: (context, index) {
                          final popularPros = state.theProducts[index];
                          return ProductTile(
                          kHeight: kHeight * 1,
                          kWidth: kWidth * 0.4,
                          anProductImg: popularPros["productImages"][0],
                          textProducts: popularPros["itemName"],
                          textPrice: popularPros["price"],
                          imageHeight: kHeight * 0.15,
                          imageWidth: kWidth * 0.35,
                        );
                        },
                      );
                    }
                  },
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
                    borderRadius: BorderRadius.all(Radius.circular(
                      20,
                    ))),
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
                child: AnGridView(
                  kHeight: kHeight * 1,
                  kWidth: kWidth * .5,
                  anProductimg: carouselImages[0],
                  textProducts: textProducts[0],
                  textPrice: textPrice[0],
                  imageSize: kHeight * 0.18,
                  imageWidth: kWidth * 0.5,
                ),
              ),
              SizedBox(height: kHeight * 0.065),
            ],
          ),
        ),
      ),
    );
  }
}

class AnGridView extends StatelessWidget {
  const AnGridView({
    super.key,
    required this.kHeight,
    required this.kWidth,
    required this.anProductimg,
    required this.textProducts,
    required this.textPrice,
    required this.imageSize,
    required this.imageWidth,
  });

  final double kHeight;
  final double kWidth;
  final String anProductimg;
  final String textProducts;
  final String textPrice;
  final double imageSize;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 5,
        mainAxisExtent: 230,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ProductTile(
          kHeight: kHeight,
          kWidth: kWidth,
          imageHeight: imageSize,
          anProductImg: anProductimg,
          textProducts: textProducts,
          textPrice: textPrice,
          imageWidth: imageWidth,
        );
      },
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.kWidth,
    required this.kHeight,
    required this.anProductImg,
    required this.textProducts,
    required this.textPrice,
    required this.imageHeight,
    required this.imageWidth,
  });
  final double kWidth;
  final double kHeight;
  final double imageHeight;
  final String anProductImg;
  final String textProducts;
  final String textPrice;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight,
      width: kWidth,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.flip(
              flipX: true,
              child: Transform.rotate(
                angle: pi / 10.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    height: imageHeight,
                    width: imageWidth,
                    decoration: BoxDecoration(
                      //color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(anProductImg),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Brandname",
              style: italicText,
            ),
            Text(textProducts.toUpperCase(), style: kHeadingMedText),
            Text(textPrice, style: kSubTitleText),
          ],
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
