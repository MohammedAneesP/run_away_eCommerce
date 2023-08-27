part of 'cart_button_bloc.dart';

@immutable
sealed class CartButtonEvent {}

class CartProducts extends CartButtonEvent {
  final String anEmail;
  CartProducts({required this.anEmail});
}

class AddingToCart extends CartButtonEvent {
  final String anEmail;
  final String anProductId;
  AddingToCart({required this.anProductId, required this.anEmail});
}
