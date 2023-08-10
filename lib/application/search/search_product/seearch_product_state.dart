part of 'seearch_product_bloc.dart';

class SearchProductState {
final List<dynamic> allProductsList;
final List<dynamic>searchProducts;
SearchProductState({required this.allProductsList,required this.searchProducts});
}

class SearchProductInitial extends SearchProductState {
 SearchProductInitial():super(allProductsList: [],searchProducts: []);
}
