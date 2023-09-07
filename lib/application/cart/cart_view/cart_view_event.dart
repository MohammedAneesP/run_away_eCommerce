part of 'cart_view_bloc.dart';

@immutable
sealed class CartViewEvent {}

class ProductsInCart extends CartViewEvent {
  final String anEmail;
  ProductsInCart({required this.anEmail});
}

class CartItemRemove extends CartViewEvent {
  final String anProductId;
  final String anEmail;
  CartItemRemove({required this.anEmail, required this.anProductId});
}

class CartUpdatingCount extends CartViewEvent {
  final String anEmail;
  final Map<String, dynamic> anUpdateMap;
  CartUpdatingCount({required this.anEmail, required this.anUpdateMap});
}
