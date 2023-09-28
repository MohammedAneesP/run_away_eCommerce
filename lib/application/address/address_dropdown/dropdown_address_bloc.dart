import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:run_away/presentation/Screens/address.dart/address.dart';

part 'dropdown_address_event.dart';
part 'dropdown_address_state.dart';

class DropDownAddressBloc
    extends Bloc<DropdownAddressEvent, DropdownAddressState> {
  DropDownAddressBloc() : super(DropdownAddressInitial()) {
    on<AddressChanging>((event, emit) {
      anSelectedAddress = event.address;
      return emit(DropdownAddressState(anSelectedAddress: anSelectedAddress));
    });
  }
}
