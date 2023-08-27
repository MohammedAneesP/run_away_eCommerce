part of 'product_in_brand_bloc.dart';

class ProductInBrandState {
  final List<dynamic> products;
  final String errorMessage;
  ProductInBrandState({required this.products,required this.errorMessage});
}

class ProductInBrandInitial extends ProductInBrandState {
  ProductInBrandInitial():super(products: [],errorMessage: "");
}
