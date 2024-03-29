part of 'adding_address_bloc.dart';

@immutable
sealed class AddingAddressEvent {}

class AddingAnAddress extends AddingAddressEvent {
  final String anEmail;
  final String userEmail;
  final String name;
  final String place;
  final String address;
  final String landmark;
  final String number;
  final String pincode;
  final String editAddressKey;
  AddingAnAddress({
    required this.userEmail,
    required this.anEmail,
    required this.place,
    required this.address,
    required this.landmark,
    required this.name,
    required this.number,
    required this.pincode,
    required this.editAddressKey,
  });
}
