import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/home_page/all_products/all_products_bloc.dart';
import 'package:run_away/application/home_page/home_choice/brand_choice_bloc.dart';
import 'package:run_away/application/home_page/popular_picks/popular_product_bloc.dart';
import 'package:run_away/application/wishlist/fav_icon/fav_icon_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/presentation/Screens/login_sign_up_pages/login_page.dart';
import 'package:run_away/presentation/widgets/brands/brand_name_get.dart';

import 'widgets/popular_product_tile.dart';
import '../../widgets/products/fav_grid_tile/product_grid_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userName = FireBaseAuthMethods(FirebaseAuth.instance);
  final fireName = FirebaseAuth.instance.currentUser;

  final List<dynamic> carouselImages = [
    "assets/landing_pic_1.png",
    "assets/landing_pic_2.png",
    "assets/landing_pic_3.png",
   ];

  final brandCollection = FirebaseFirestore.instance.collection("brands");

  bool isSelected = false;

  List<dynamic> getId = [];

  final gettingProId = [];

  ValueNotifier<int> anSelectVal = ValueNotifier(-1);

  void changeValue(int anItem) {
    anSelectVal.value = ValueNotifier(anItem).value;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BrandChoiceBloc>(context).add(DisplayBrand());
    BlocProvider.of<PopularProductBloc>(context).add(SomeProduct());
    BlocProvider.of<AllProductsBloc>(context).add(AllProductListing());
    BlocProvider.of<FavIconBloc>(context).add(FavProduct(anEmail: fireName!.email.toString()));
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

   // print("${fireName!.email}----------");
    var sizedBoxGap = SizedBox(height: kHeight * 0.05);
    var sizedBoxGap3 = SizedBox(height: kHeight * 0.03);
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
              CarouselSlider(
                options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1),
                items: carouselImages.map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: kGrey.withOpacity(0.1),
                            image: DecorationImage(
                                image: AssetImage(i), fit: BoxFit.cover),
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
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
                height: kHeight * .3,
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
                          final itemsName =
                              capitalizeFirstLetter(popularPros["itemName"]);
                          return ProductTile(
                            kHeight: kHeight * 1,
                            kWidth: kWidth * 0.45,
                            anProductImg: popularPros["productImages"][0],
                            textProducts: itemsName,
                            textPrice: popularPros["price"],
                            brandName: BrandNameStream(
                                popularPros: popularPros, anStyle: italicText),
                            imageHeight: kHeight * 0.2,
                            imageWidth: kWidth * 0.5,
                            // anIconButton: IconButton(onPressed: , icon: icon),
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
              sizedBoxGap3,
              BlocBuilder<AllProductsBloc, AllProductsState>(
                builder: (context, state) {
                  if (state.allProducts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final product = state.allProducts[2];
                    final productName =
                        capitalizeFirstLetter(product["itemName"]);
                    return Container(
                      height: kHeight * .17,
                      decoration: const BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 185,
                            // color: Colors.amber,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  BrandNameStream(
                                    popularPros: product,
                                    anStyle: kBlueText,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(productName, style: kTitleText),
                                  const SizedBox(height: 5),
                                  Text("₹ ${product['price']}",
                                      style: kNonBoldBigText)
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 40),
                            child: Transform.flip(
                              flipX: true,
                              child: Transform.rotate(
                                angle: pi / 12.5,
                                child: Container(
                                  height: 120,
                                  width: 175,
                                  decoration: BoxDecoration(
                                      //  color: Colors.red,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            product["productImages"][0],
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
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
                // height: kHeight * 1.4,
                child: BlocBuilder<AllProductsBloc, AllProductsState>(
                  builder: (context, state) {
                    if (state.allProducts.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 220,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 5,
                              mainAxisExtent: 260,
                            ),
                            itemCount: state.allProducts.length,
                            itemBuilder: (context, index) {
                                  
                              final productData = state.allProducts[index];
                              final productName = capitalizeFirstLetter(
                                  productData["itemName"]);
                                  
                              return ProductGridTile(
                                kHeight: 0,
                                kWidth: 0,
                                imageHeight: kHeight * 0.15,
                                imageWidth: kWidth * 0.5,
                                anProductImg: productData["productImages"][0],
                                anProductId: productData["productId"],
                                textProducts: productName,
                                textPrice: productData["price"],
                                anEmail: fireName!.email.toString(),
                                brandName: BrandNameStream(
                                  popularPros: productData,
                                  anStyle: italicText,
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
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
