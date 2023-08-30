part of 'cart_button_bloc.dart';

 class CartButtonState {
  final Map<dynamic,dynamic>productId;
  final String errorMessage;
  CartButtonState({required this.productId,required this.errorMessage});
 }

final class CartButtonInitial extends CartButtonState {
  CartButtonInitial():super(productId: {},errorMessage: '');
}
