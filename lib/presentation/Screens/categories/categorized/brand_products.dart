import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/category/product_in_brand/product_in_brand_bloc.dart';
import 'package:run_away/application/home_page/home_choice/brand_choice_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/infrastructure/home_page/brand_name_get.dart';
import 'package:run_away/presentation/Screens/product_details/product_view.dart';
import 'package:run_away/presentation/widgets/products/fav_grid_tile/product_grid_tile.dart';

class BrandsProducts extends StatelessWidget {
  final String anBrandId;
  final int anSelectedIndex;
  BrandsProducts({
    super.key,
    required this.anSelectedIndex,
    required this.anBrandId,
  });

  final fireName = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> anSelectVal = ValueNotifier(anSelectedIndex);
    final ValueNotifier<String> changeBrandsId = ValueNotifier(anBrandId);

    void changeValue(int anItem, String anId) {
      anSelectVal.value = ValueNotifier(anItem).value;
      changeBrandsId.value = ValueNotifier(anId).value;
    }

    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Products".toUpperCase(), style: kTitleText),
        shadowColor: kTransparent,
        backgroundColor: kGrey200,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: kWhite,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: kBlack,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: kHeight.height * 0.09,
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
                        width: kWidth.width * 0.05,
                      ),
                      itemCount: state.theBrands.length,
                      itemBuilder: (context, index) {
                        final refName = state.theBrands[index];
                        return ValueListenableBuilder(
                          valueListenable: anSelectVal,
                          builder: (context, value, _) {
                            BlocProvider.of<ProductInBrandBloc>(context).add(
                                TheProducts(anProductId: changeBrandsId.value));
                            return ChoiceChip(
                              backgroundColor: Colors.transparent,
                              selectedColor: Colors.lightBlue,
                              selected: anSelectVal.value == index,
                              onSelected: (value) {
                                changeValue(index, refName["brandId"]);
                                BlocProvider.of<ProductInBrandBloc>(context)
                                    .add(TheProducts(
                                        anProductId: changeBrandsId.value));
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
                                      builder:
                                          (BuildContext context, value, _) =>
                                              Text(
                                        "${refName["brandName"]}".toUpperCase(),
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
            BlocBuilder<ProductInBrandBloc, ProductInBrandState>(
              builder: (context, state) {
                if (state.products.isEmpty) {
                  return Center(
                    child: SizedBox(
                      height: kHeight.height * .65,
                      child: const Center(
                        child: Text(
                          "No product Available",
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: kHeight.height,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            itemCount: state.products.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 220,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 5,
                              mainAxisExtent: 260,
                            ),
                            itemBuilder: (context, index) {
                              final theProducts = state.products[index];
                              final productName =
                                  capitalizeFirstLetter(theProducts["itemName"]);
                              return ProductGridTile(
                                kHeight: 0,
                                kWidth: 0,
                                anOnPressed: () =>
                                    Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductView(
                                      anProductId: theProducts["productId"]),
                                )),
                                imageHeight: kHeight.height * 0.15,
                                imageWidth: kWidth.width * 0.5,
                                anProductImg: theProducts["productImages"][0],
                                anProductId: theProducts["productId"],
                                textProducts: productName,
                                textPrice: theProducts["price"],
                                anEmail: fireName!.email.toString(),
                                brandName: BrandNameStream(
                                  popularPros: theProducts,
                                  anStyle: kBlueThinText,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
