import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/application/category/product_in_brand/product_in_brand_bloc.dart';
import 'package:run_away/application/home_page/all_products/all_products_bloc.dart';
import 'package:run_away/application/home_page/home_choice/brand_choice_bloc.dart';
import 'package:run_away/application/home_page/popular_picks/popular_product_bloc.dart';
import 'package:run_away/application/profile/profile_display/profile_displaying_bloc.dart';
import 'package:run_away/application/wishlist/fav_icon/fav_icon_bloc.dart';
import 'package:run_away/application/wishlist/wishlist_products/wishlist_products_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/cart/my_cart.dart';
import 'package:run_away/presentation/Screens/categories/categorized/brand_products.dart';
import 'package:run_away/presentation/Screens/product_details/product_view.dart';
import 'package:run_away/presentation/Screens/search_screen/search_screen.dart';
import 'package:run_away/infrastructure/home_page/brand_name_get.dart';
import 'package:run_away/presentation/widgets/fav_grid_tile/product_grid_tile.dart';

import 'widgets/drawer.dart';
import 'widgets/home_titles/all_products.dart';
import 'widgets/home_titles/new_arrival.dart';
import 'widgets/home_titles/popular_pick.dart';
import 'widgets/image_containers/carousal_image.dart';
import 'widgets/new_arrival_prodct.dart';
import 'widgets/popular_product_tile.dart';

final List<dynamic> carouselImages = [
  "assets/IMG_20240211_121539-removebg-preview.png",
  "assets/IMG_20240211_121635-removebg-preview.png",
  "assets/IMG_20240211_121846-removebg-preview.png",
];

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final fireName = FirebaseAuth.instance.currentUser;

  final ValueNotifier<int> anSelectVal = ValueNotifier(-1);

  void changeValue(int anItem) {
    anSelectVal.value = ValueNotifier(anItem).value;
  }

  final screenNames = [
    "Profile",
    "Home Page",
    "My Cart",
    "Wishlists",
    "Orders",
  ];
  final screenIcons = [
    const Icon(CupertinoIcons.person, color: kBlack),
    const Icon(CupertinoIcons.house, color: kBlack),
    const Icon(CupertinoIcons.cart, color: kBlack),
    const Icon(CupertinoIcons.heart, color: kBlack),
    const Icon(CupertinoIcons.bag, color: kBlack),
  ];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileDisplayingBloc>(context)
        .add(GetProfile(anEmail: fireName!.email.toString()));
    BlocProvider.of<BrandChoiceBloc>(context).add(DisplayBrand());
    BlocProvider.of<PopularProductBloc>(context).add(SomeProduct());
    BlocProvider.of<AllProductsBloc>(context).add(AllProductListing());
    BlocProvider.of<FavIconBloc>(context)
        .add(FavProduct(anEmail: fireName!.email.toString()));
    BlocProvider.of<WishlistProductsBloc>(context)
        .add(WishProductList(anEmail: fireName!.email.toString()));

    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    double bluThinSize = kHeight < 750 ? 13 : 18;
    final kBlueThinText = GoogleFonts.roboto(
        color: kBlue, fontSize: bluThinSize, fontWeight: FontWeight.w300);
    var sizedBoxGap = SizedBox(height: kHeight * 0.05);
    var sizedBoxGap3 = SizedBox(height: kHeight * 0.03);
    return Scaffold(
      drawer: HomeDrawer(
        anName: fireName!.displayName.toString(),
        kHeight: kHeight,
        screenNames: screenNames,
        kWidth: kWidth,
        screenIcons: screenIcons,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              snap: true,
              floating: true,
              elevation: 0,
              surfaceTintColor: kTransparent,
              bottom: const PreferredSize(
                  preferredSize: Size(0, 15), child: SizedBox()),
              backgroundColor: kGrey200,
              leading: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Container(
                    height: kHeight * 0.001,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(
                        CupertinoIcons.square_grid_2x2_fill,
                        size: 20,
                      ),
                    ),
                  ),
                );
              }),
              title: Text("SHOEWEE", style: textMainTitle),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: CircleAvatar(
                    backgroundColor: kWhite,
                    radius: 30,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyCart(),
                          ),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.cart,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
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
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
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
                                          onSelected: (value) async {
                                            changeValue(index);

                                            BlocProvider.of<ProductInBrandBloc>(
                                                    context)
                                                .add(TheProducts(
                                                    anProductId:
                                                        refName["brandId"]));
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BrandsProducts(
                                                  anSelectedIndex:
                                                      anSelectVal.value,
                                                  anBrandId: refName["brandId"],
                                                ),
                                              ),
                                            );
                                            changeValue(-1);
                                          },
                                          labelPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 8),
                                          avatar: CachedNetworkImage(
                                            imageUrl: refName["imageName"],
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: kWhite,
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          label: anSelectVal.value == index
                                              ? ValueListenableBuilder(
                                                  valueListenable: anSelectVal,
                                                  builder:
                                                      (BuildContext context,
                                                              value, _) =>
                                                          Text(
                                                    "${refName["brandName"]}"
                                                        .toUpperCase(),
                                                  ),
                                                )
                                              : ValueListenableBuilder(
                                                  valueListenable: anSelectVal,
                                                  builder:
                                                      (context, value, child) =>
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
                      child:
                          BlocBuilder<PopularProductBloc, PopularProductState>(
                        builder: (context, state) {
                          if (state.theProducts.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
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
                                final itemsName = capitalizeFirstLetter(
                                    popularPros["itemName"]);
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
                          return const Center(
                              child: CircularProgressIndicator());
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
                            return const Center(
                                child: CircularProgressIndicator());
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
                                    final productData =
                                        state.allProducts[index];
                                    final productName = capitalizeFirstLetter(
                                        productData["itemName"]);

                                    return ProductGridTile(
                                      kHeight: 0,
                                      kWidth: 0,
                                      anOnPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => ProductView(
                                            anProductId:
                                                productData["productId"]),
                                      )),
                                      imageHeight: kHeight * 0.15,
                                      imageWidth: kWidth * 0.5,
                                      anProductImg: productData["productImages"]
                                          [0],
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
          ],
        ),
      ),
    );
  }
}
