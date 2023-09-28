part of 'displaying_all_orders_bloc.dart';

@immutable
sealed class DisplayingAllOrdersEvent {}

class OrdersDisplaying extends DisplayingAllOrdersEvent {
  final String anEmail;
  OrdersDisplaying({required this.anEmail});
}
