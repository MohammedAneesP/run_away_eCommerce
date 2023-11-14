import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_away/application/search/search_product/seearch_product_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';
import 'package:run_away/presentation/Screens/product_details/product_view.dart';
import 'package:run_away/presentation/Screens/wishlist/widgets/appbar_widgets/leading_widget.dart';
import 'package:run_away/infrastructure/home_page/brand_name_get.dart';

final List<String> historyList = [];

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController anController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);

    BlocProvider.of<SearchProductBloc>(context).add(SearchResult(query: ""));
    // final theHeight = MediaQuery.of(context).size.height;
    // double headSize = theHeight < 750 ? 16 : 20;
    // final kHeadingText = GoogleFonts.roboto(
    // fontWeight: FontWeight.bold, fontSize: headSize, color: kBlack);
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
        appBar: AppBar(
          bottom: const PreferredSize(
              preferredSize: Size(0, 20), child: SizedBox()),
          elevation: 0,
          backgroundColor: kGrey200,
          centerTitle: true,
          leading: const AppbarLeading(),
          title: Text("Search", style: loginTitle),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavPage(),
                  ),
                );
              },
              child: Text(
                "Cancel",
                style: kBlueText,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoSearchTextField(
                  autofocus: true,
                  controller: anController,
                  padding: const EdgeInsets.fromLTRB(17, 17, 17, 17),
                  backgroundColor: kWhite.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                  onChanged: (value) {
                    BlocProvider.of<SearchProductBloc>(context)
                        .add(SearchResult(query: value));
                    if (value.isNotEmpty) {
                      if (historyList.length == 5) {
                        historyList.removeLast();
                        historyList.insert(0, value);
                      } else {
                        historyList.insert(0, value);
                      }
                    }
                  },
                ),
                BlocBuilder<SearchProductBloc, SearchProductState>(
                  builder: (context, state) {
                    if (state.searchProducts.isNotEmpty) {
                      return SizedBox(
                        height: kHeight.height,
                        width: kWidth.width,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              final anProduct = state.searchProducts[index];
                              final productName =
                                  capitalizeFirstLetter(anProduct["itemName"]);
                              return ListTile(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProductView(
                                      anProductId: anProduct["productId"],
                                    ),
                                  ),
                                ),
                                leading: Container(
                                  height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    // color: kGrey,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        anProduct["productImages"][0],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  productName,
                                  style: kNonboldTitleText,
                                ),
                                subtitle: BrandNameStream(
                                    popularPros: anProduct,
                                    anStyle: kBluePlainText),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: state.searchProducts.length),
                      );
                    } else if (state.allProductsList.isEmpty &&
                        state.searchProducts.isEmpty) {
                      return SizedBox(
                        height: 400,
                        child: Center(
                          child: Text(
                            "Product Not Found",
                            style: kHeadingText,
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            child: LayoutBuilder(
                              builder: (context, constraints) =>
                                  ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: historyList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      anController.text = historyList[index];
                                      BlocProvider.of<SearchProductBloc>(
                                              context)
                                          .add(SearchResult(
                                              query: anController.text));
                                    },
                                    leading: const Icon(Icons.access_time),
                                    title: Text(
                                      historyList[index],
                                      style: kSubTitleText,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// SizedBox(
//   height: kHeight.height,
//   width: kWidth.width,
//   child: ListView.separated(
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         final anProduct = state.allProductsList[index];
//         final productName = capitalizeFirstLetter(
//             anProduct["itemName"]);
//         return ListTile(
//           onTap: () {
            
//           },
//           leading: Container(
//             height: 30,
//             width: 50,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                   anProduct["productImages"][0],
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           title: Text(
//             productName,
//             style: kNonboldTitleText,
//           ),
//           subtitle: BrandNameStream(
//               popularPros: anProduct,
//               anStyle: kBluePlainText),
//         );
//       },
//       separatorBuilder: (context, index) =>
//           const Divider(),
//       itemCount: state.allProductsList.length),
// ),