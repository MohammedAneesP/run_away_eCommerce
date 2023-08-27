part of 'cart_button_bloc.dart';

 class CartButtonState {
  final List<dynamic>productId;
  final String errrorMessage;
  CartButtonState({required this.productId,required this.errrorMessage});
 }

final class CartButtonInitial extends CartButtonState {
  CartButtonInitial():super(productId: [],errrorMessage: '');
}
