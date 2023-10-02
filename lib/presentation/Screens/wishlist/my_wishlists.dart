import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/wishlist/fav_icon/fav_icon_bloc.dart';
import 'package:run_away/application/wishlist/wishlist_products/wishlist_products_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/product_details/product_view.dart';
import 'package:run_away/presentation/widgets/fav_grid_tile/product_grid_tile.dart';
import 'package:run_away/infrastructure/home_page/brand_name_get.dart';

import 'widgets/appbar_widgets/action_widget.dart';
import 'widgets/appbar_widgets/leading_widget.dart';

class MyWishlist extends StatelessWidget {
  MyWishlist({super.key});
  final fireName = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<WishlistProductsBloc>(context)
          .add(WishProductList(anEmail: fireName!.email.toString()));
    });

    final kWidth = MediaQuery.sizeOf(context);
    final kHeight = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kGrey200,
          elevation: 0,
          leading: const AppbarLeading(),
          centerTitle: true,
          title: Text("Favorite", style: loginTitle),
          actions: const [AppbarActionWidg()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<WishlistProductsBloc, WishlistProductsState>(
            builder: (context, state) {
              if (state.wishProducts.isEmpty) {
                return Center(child: Text(state.errorMessage));
              } else {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 5,
                    mainAxisExtent: 260,
                  ),
                  itemCount: state.wishProducts.length,
                  itemBuilder: (context, index) {
                    final favProducts = state.wishProducts[index];
                    if (anFavList.contains(favProducts["productId"])) {
                      final productname =
                          capitalizeFirstLetter(favProducts["itemName"]);
                      return ProductGridTile(
                        anOnPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductView(
                              anProductId: favProducts["productId"]),
                        )),
                        kWidth: 0,
                        kHeight: 0,
                        anProductImg: favProducts["productImages"][0],
                        textProducts: productname,
                        brandName: BrandNameStream(
                          popularPros: favProducts,
                          anStyle: kBlueThinText,
                        ),
                        textPrice: favProducts["price"],
                        imageHeight: kHeight.height * 0.15,
                        imageWidth: kWidth.width * 0.5,
                        anEmail: fireName!.email.toString(),
                        anProductId: favProducts["productId"],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              }
            },
          ),
        ));
  }
}
