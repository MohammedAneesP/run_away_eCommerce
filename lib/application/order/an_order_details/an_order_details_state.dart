part of 'an_order_details_bloc.dart';

class AnOrderDetailsState {
  final Map<String, dynamic> anOrder;
  final Map<String, dynamic> anProduct;
  final bool isLoading;

  AnOrderDetailsState({
    required this.anOrder,
    required this.anProduct,
    required this.isLoading,
  });
}

class AnOrderDetailsInitial extends AnOrderDetailsState {
  AnOrderDetailsInitial() : super(anOrder: {}, anProduct: {},isLoading: false);
}
