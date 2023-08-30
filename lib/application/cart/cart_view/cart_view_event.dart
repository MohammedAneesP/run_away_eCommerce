part of 'cart_view_bloc.dart';

@immutable
sealed class CartViewEvent {}

class ProductsInCart extends CartViewEvent {
  final String anEmail;
  ProductsInCart({required this.anEmail});
}
