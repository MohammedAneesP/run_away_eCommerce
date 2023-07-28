part of 'all_products_bloc.dart';

class AllProductsState {
  final String errorMessage;
  final List<dynamic> allProducts;
  AllProductsState({required this.allProducts,required this.errorMessage});
}

class AllProductsInitial extends AllProductsState {
  AllProductsInitial():super(allProducts: [],errorMessage: "");
}
