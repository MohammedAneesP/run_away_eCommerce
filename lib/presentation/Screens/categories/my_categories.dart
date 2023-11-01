import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/home_page/home_choice/brand_choice_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/categories/categorized/brand_products.dart';
import 'package:run_away/presentation/Screens/home_page/zoom_drawer/zomm_drawer.dart';
import 'package:run_away/presentation/Screens/wishlist/widgets/appbar_widgets/leading_widget.dart';

const tempImage =
    "https://as2.ftcdn.net/v2/jpg/04/00/24/31/1000_F_400243185_BOxON3h9avMUX10RsDkt3pJ8iQx72kS3.jpg";

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ForZoom(),
          ),
        );
        return true;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              bottom: const PreferredSize(
                  preferredSize: Size(0, 17), child: SizedBox()),
              shadowColor: kTransparent,
              backgroundColor: kGrey200,
              centerTitle: true,
              leading: const AppbarLeading(),
              title: Text("Brands", style: loginTitle),
            ),
            BlocBuilder<BrandChoiceBloc, BrandChoiceState>(
                builder: (context, state) {
              if (state.theBrands.isEmpty) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state.theBrands.isNotEmpty) {
                return SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 10,
                    mainAxisExtent: 195,
                  ),
                  itemCount: state.theBrands.length,
                  itemBuilder: (context, index) {
                    final brand = state.theBrands[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BrandsProducts(
                              anSelectedIndex: index,
                              anBrandId: brand["brandId"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        height: kHeight.height * 0.8,
                        width: kWidth.width * 1,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: kHeight.height * .17,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      brand["imageName"] ?? tempImage,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${brand["brandName"]}".toUpperCase(),
                              style: kHeadingMedText,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const SliverToBoxAdapter(
                    child: Center(child: Text("Something went Wrong")));
              }
            })
          ],
        ),
      ),
    );
  }
}
