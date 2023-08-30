part of 'cart_view_bloc.dart';

class CartViewState {
  final List <dynamic> cartProducts;
  final String errorMessage;
  CartViewState({required this.cartProducts,required this.errorMessage});
}

class CartViewInitial extends CartViewState {
  CartViewInitial():super(cartProducts: [],errorMessage: "");
}
