part of 'an_order_details_bloc.dart';

@immutable
sealed class AnOrderDetailsEvent {}

class DisplayAnOerder extends AnOrderDetailsEvent {
  final String anProductKey;
  final String anOrderKey;
  DisplayAnOerder({required this.anOrderKey, required this.anProductKey});
}

class DisplayOrderClearing extends AnOrderDetailsEvent {}

class CancellingOrder extends AnOrderDetailsEvent {
  final String anProductKey;
  final String anOrderKey;
  CancellingOrder({required this.anOrderKey, required this.anProductKey});
}
