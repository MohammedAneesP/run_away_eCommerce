part of 'address_edit_bloc.dart';

class AddressEditState {
  final String anErrorMessage;
  final Map<String, dynamic> theAddresses;
  AddressEditState({
    required this.anErrorMessage,
    required this.theAddresses,
  });
}

final class AddressEditInitial extends AddressEditState {
  AddressEditInitial():super(anErrorMessage: "",theAddresses: {});
}
