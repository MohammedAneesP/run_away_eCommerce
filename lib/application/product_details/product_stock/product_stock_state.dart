part of 'product_stock_bloc.dart';

class ProductStockState {
  final String successMessage;
  final String errorMesssage;
  ProductStockState(
      {required this.errorMesssage, required this.successMessage});
}

class ProductStockInitial extends ProductStockState {
  ProductStockInitial() : super(errorMesssage: "", successMessage: "");
}
