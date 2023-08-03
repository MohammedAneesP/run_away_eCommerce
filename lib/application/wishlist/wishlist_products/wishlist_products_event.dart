part of 'wishlist_products_bloc.dart';

@immutable
abstract class WishlistProductsEvent {}

class WishProductList extends WishlistProductsEvent {
  final String anEmail;
  WishProductList({required this.anEmail});
}

class RemoveFavorite extends WishlistProductsEvent {
  final String anEmail;
  final String anProductId;
  RemoveFavorite({required this.anProductId, required this.anEmail});
}
