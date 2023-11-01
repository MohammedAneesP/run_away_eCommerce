part of 'dropdown_address_bloc.dart';

@immutable
sealed class DropdownAddressEvent {}

class AddressChanging extends DropdownAddressEvent {
 final  String address;
  AddressChanging({required this.address});
}
