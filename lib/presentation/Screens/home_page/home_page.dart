import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/category/product_in_brand/product_in_brand_bloc.dart';
import 'package:run_away/application/home_page/all_products/all_products_bloc.dart';
import 'package:run_away/application/home_page/home_choice/brand_choice_bloc.dart';
import 'package:run_away/application/home_page/popular_picks/popular_product_bloc.dart';
import 'package:run_away/application/wishlist/fav_icon/fav_icon_bloc.dart';
import 'package:run_away/application/wishlist/wishlist_products/wishlist_products_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/presentation/Screens/categories/categorized/brand_products.dart';
import 'package:run_away/presentation/Screens/login_sign_up_pages/login_page.dart';
import 'package:run_away/presentation/Screens/product_details/product_view.dart';
import 'package:run_away/presentation/Screens/search_screen/search_screen.dart';
import 'package:run_away/infrastructure/home_page/brand_name_get.dart';
import 'package:run_away/presentation/widgets/products/fav_grid_tile/product_grid_tile.dart';

import 'widgets/home_titles/all_products.dart';
import 'widgets/home_titles/new_arrival.dart';
import 'widgets/home_titles/popular_pick.dart';
import 'widgets/image_containers/carousal_image.dart';
import 'widgets/new_arrival_prodct.dart';
import 'widgets/popular_product_tile.dart';

final List<dynamic> carouselImages = [
  "assets/landing_pic_1.png",
  "assets/landing_pic_2.png",
  "assets/landing_pic_3.png",
];

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final userName = FireBaseAuthMethods(FirebaseAuth.instance);
  final fireName = FirebaseAuth.instance.currentUser;

  final ValueNotifier<int> anSelectVal = ValueNotifier(-1);

  void changeValue(int anItem) {
    anSelectVal.value = ValueNotifier(anItem).value;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BrandChoiceBloc>(context).add(DisplayBrand());
    BlocProvider.of<PopularProductBloc>(context).add(SomeProduct());
    BlocProvider.of<AllProductsBloc>(context).add(AllProductListing());
   BlocProvider.of<FavIconBloc>(context)
       .add(FavProduct(anEmail: fireName!.email.toString()));
        BlocProvider.of<WishlistProductsBloc>(context).add(WishProductList(anEmail: fireName!.email.toString()));

    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    var sizedBoxGap = SizedBox(height: kHeight * 0.05);
    var sizedBoxGap3 = SizedBox(height: kHeight * 0.03);
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
        surfaceTintColor: kTransparent,
        bottom:
            const PreferredSize(preferredSize: Size(0, 15), child: SizedBox()),
        backgroundColor: kGrey200,
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
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                )),
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
                        return CarousalImageContainer(anImage: i);
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
                              return ValueListenableBuilder(
                                valueListenable: anSelectVal,
                                builder: (context, value, _) {
                                  return ChoiceChip(
                                    backgroundColor: Colors.transparent,
                                    selectedColor: Colors.lightBlue,
                                    selected: anSelectVal.value == index,
                                    onSelected: (value)async {
                                      changeValue(index);

                                      BlocProvider.of<ProductInBrandBloc>(
                                              context)
                                          .add(TheProducts(
                                              anProductId: refName["brandId"]));
                                     await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BrandsProducts(
                                            anSelectedIndex: anSelectVal.value,
                                            anBrandId: refName["brandId"],
                                          ),
                                        ),
                                      );
                                      changeValue(-1);
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
              const PopularPickText(),
              SizedBox(height: kHeight * 0.02),
              SizedBox(
                height: kHeight * .31,
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
                            anOnPress: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductView(
                                    anProductId: popularPros["productId"],
                                  ),
                                ),
                              );
                            },
                            kHeight: kHeight * 1,
                            kWidth: kWidth * 0.45,
                            anProductImg: popularPros["productImages"][0],
                            textProducts: itemsName,
                            textPrice: popularPros["price"],
                            brandName: BrandNameStream(
                                popularPros: popularPros,
                                anStyle: kBlueThinText),
                            imageHeight: kHeight * 0.2,
                            imageWidth: kWidth * 0.5,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              sizedBoxGap,
              const NewArrivalText(),
              sizedBoxGap3,
              BlocBuilder<AllProductsBloc, AllProductsState>(
                builder: (context, state) {
                  if (state.allProducts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final product = state.allProducts[0];
                    final productName =
                        capitalizeFirstLetter(product["itemName"]);
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductView(
                            anProductId: product["productId"],
                          ),
                        ),
                      ),
                      child: NewArrivalProduct(
                        product: product,
                        productName: productName,
                      ),
                    );
                  }
                },
              ),
              sizedBoxGap,
              const AllProductText(),
              SizedBox(height: kHeight * 0.03),
              SizedBox(
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
                                anOnPressed: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => ProductView(
                                      anProductId: productData["productId"]),
                                )),
                                imageHeight: kHeight * 0.15,
                                imageWidth: kWidth * 0.5,
                                anProductImg: productData["productImages"][0],
                                anProductId: productData["productId"],
                                textProducts: productName,
                                textPrice: productData["price"],
                                anEmail: fireName!.email.toString(),
                                brandName: BrandNameStream(
                                  popularPros: productData,
                                  anStyle: kBlueThinText,
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
