part of 'popular_product_bloc.dart';

class PopularProductState {
  final List<dynamic> theProducts;
  final String errorMessage;
  PopularProductState({required this.theProducts, required this.errorMessage});
}

class PopularProductInitial extends PopularProductState {
  PopularProductInitial() : super(theProducts: [], errorMessage: '');
}
