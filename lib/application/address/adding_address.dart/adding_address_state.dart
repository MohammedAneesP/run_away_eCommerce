part of 'adding_address_bloc.dart';

class AddingAddressState {
  final String errorMessage;
  final Map<String,dynamic> anAddress;
  AddingAddressState({required this.errorMessage,required this.anAddress,});
}

 class AddingAddressInitial extends AddingAddressState {
  AddingAddressInitial():super(errorMessage: "",anAddress: {});
 }
