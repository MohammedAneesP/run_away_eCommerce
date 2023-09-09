part of 'address_view_bloc.dart';

@immutable
sealed class AddressViewEvent {}

class ViewingAddresses extends AddressViewEvent {
  final String anEmail;
  ViewingAddresses({required this.anEmail});
}
