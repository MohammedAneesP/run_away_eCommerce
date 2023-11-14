part of 'product_stock_bloc.dart';

@immutable
sealed class ProductStockEvent {}

class UpdatingProduct extends ProductStockEvent{
  final Map<String,dynamic>anStockSizeCount;
  UpdatingProduct({required this.anStockSizeCount});
}
