part of 'dropdown_address_bloc.dart';

@immutable
sealed class DropdownAddressEvent {}

class AddressChanging extends DropdownAddressEvent {
   String address;
  AddressChanging({required this.address});
}
