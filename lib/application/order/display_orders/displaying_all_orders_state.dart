part of 'displaying_all_orders_bloc.dart';

class DisplayingAllOrdersState {
  final List<dynamic> userOrderKey;
  final List<dynamic> userProductKey;
  final Map<String,dynamic> orders;
  final Map<String,dynamic> products; 
  final bool isLoading;
  
  DisplayingAllOrdersState(
      { required this.userOrderKey,required this.products,required this.isLoading,required this.orders,required this.userProductKey});
}

class DisplayingAllOrdersInitial extends DisplayingAllOrdersState {
  DisplayingAllOrdersInitial() : super(orders: {}, userOrderKey: [],products: {},userProductKey: [],isLoading: true);
}
