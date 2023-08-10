part of 'product_view_bloc.dart';

class ProductViewState {
  final Map <String,dynamic> products;
  final String errorMessage;
  ProductViewState({required this.products,required this.errorMessage});
}

final class ProductViewInitial extends ProductViewState {
  ProductViewInitial():super(products: {},errorMessage: "");
}
