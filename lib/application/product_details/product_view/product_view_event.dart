part of 'product_view_bloc.dart';

@immutable
sealed class ProductViewEvent {}

class AnProductView extends ProductViewEvent{
  final String anProductid;
  AnProductView({required this.anProductid});
}

class ProductClear extends ProductViewEvent{}