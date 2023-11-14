import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:run_away/application/wishlist/fav_icon/fav_icon_bloc.dart';
import 'package:run_away/application/wishlist/wishlist_products/wishlist_products_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';
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
      BlocProvider.of<FavIconBloc>(context)
          .add(FavProduct(anEmail: fireName!.email.toString()));
    });

    final kWidth = MediaQuery.sizeOf(context);
    final kHeight = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavPage(),
          ),
        );
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: kGrey200,
                elevation: 0,
                leading: const AppbarLeading(),
                centerTitle: true,
                title: Text("Favorite", style: loginTitle),
                actions: const [AppbarActionWidg()],
              ),
              BlocBuilder<WishlistProductsBloc, WishlistProductsState>(
                builder: (context, state) {
                  if (state.wishProducts.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: kHeight.height * 0.35,
                            child: LottieBuilder.asset(
                              "assets/animation_lnpkse54.json",
                              height: kHeight.height * 0.2,
                              width: kWidth.width * 1,
                            ),
                          ),
                          const Text("You haven't added Favourites"),
                          SizedBox(height: kHeight.height * 0.01),
                        ],
                      ),
                    );
                  } else {
                    return SliverPadding(
                      padding:const EdgeInsets.all(8.0),
                      sliver: SliverGrid.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
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
                            return const SliverToBoxAdapter(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }
                },
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: kHeight.height * 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
