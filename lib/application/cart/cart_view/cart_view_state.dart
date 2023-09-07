part of 'cart_view_bloc.dart';

class CartViewState {
  final List <dynamic> cartProducts;
  final Map<dynamic,dynamic> anProductSize;
  final String errorMessage;
  CartViewState({required this.cartProducts,required this.errorMessage,required this.anProductSize});
}

class CartViewInitial extends CartViewState {
  CartViewInitial():super(cartProducts: [],errorMessage: "",anProductSize: {});
}
