part of 'dropdown_address_bloc.dart';

class DropdownAddressState {
   String anSelectedAddress;
  DropdownAddressState({required this.anSelectedAddress});
}

final class DropdownAddressInitial extends DropdownAddressState {
  DropdownAddressInitial():super(anSelectedAddress: "");
}
