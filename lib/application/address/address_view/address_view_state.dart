part of 'address_view_bloc.dart';

class AddressViewState {
  final String anErrorMessage;
  final Map<String, dynamic> addresses;
  final Map<String, dynamic> cart;
  final List<dynamic> products;
  AddressViewState({
    required this.addresses,
    required this.anErrorMessage,
    required this.cart,
    required this.products,
  });
}

final class AddressViewInitial extends AddressViewState {
  AddressViewInitial()
      : super(
          addresses: {},
          anErrorMessage: '',
          cart: {},
          products: [],
        );
}
