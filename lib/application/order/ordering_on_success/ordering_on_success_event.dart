part of 'ordering_on_success_bloc.dart';

@immutable
sealed class OrderingOnSuccessEvent {}

class AddToOrders extends OrderingOnSuccessEvent {
  final String anEmail;
  final String selectedAddressKey;
  final String shippingCharge;
  AddToOrders({required this.anEmail, required this.selectedAddressKey,required this.shippingCharge});
}
