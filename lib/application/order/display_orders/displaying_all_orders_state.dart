part of 'displaying_all_orders_bloc.dart';

class DisplayingAllOrdersState {
  final List<dynamic> userOrders;
  final Map<String,dynamic> orders;
  final Map<String,dynamic> products; 
  final bool isLoading;
  
  DisplayingAllOrdersState(
      { required this.userOrders,required this.products,required this.isLoading,required this.orders});
}

class DisplayingAllOrdersInitial extends DisplayingAllOrdersState {
  DisplayingAllOrdersInitial() : super(orders: {}, userOrders: [],products: {},isLoading: true);
}
