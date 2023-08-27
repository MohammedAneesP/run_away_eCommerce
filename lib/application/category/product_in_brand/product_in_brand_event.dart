part of 'product_in_brand_bloc.dart';

@immutable
sealed class ProductInBrandEvent {}

class TheProducts extends ProductInBrandEvent{
  final String anProductId;
  TheProducts({required this.anProductId});
}

