part of 'ordering_on_success_bloc.dart';

class OrderingOnSuccessState {
  final String anEmail;
  final String anAddressKey;
  final String errorMessage;
  final String shippingCharge;
  OrderingOnSuccessState({
    required this.anEmail,
    required this.anAddressKey,
    required this.errorMessage,
    required this.shippingCharge
  });
}

class OrderingOnSuccessInitial extends OrderingOnSuccessState {
  OrderingOnSuccessInitial()
      : super(anAddressKey: "", anEmail: "", errorMessage: "",shippingCharge: "");
}
