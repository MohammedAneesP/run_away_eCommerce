part of 'address_edit_bloc.dart';

@immutable
sealed class AddressEditEvent {}

class EditingAddress extends AddressEditEvent {
  final String anEmail;
  final String anMapKey;
  EditingAddress({required this.anEmail, required this.anMapKey});
}

class UpdatingAddress extends AddressEditEvent {
  final String anEmail;
  final String userEmail;
  final String name;
  final String place;
  final String address;
  final String landmark;
  final String number;
  final String pincode;
  final String anMapkey;
  final String editAddressKey;
  UpdatingAddress({
    required this.userEmail,
    required this.anEmail,
    required this.place,
    required this.address,
    required this.landmark,
    required this.name,
    required this.number,
    required this.pincode,
    required this.anMapkey,
    required this.editAddressKey
  });
}
