part of 'wishlist_products_bloc.dart';

class WishlistProductsState {
  final List<dynamic> wishProducts;
  final String errorMessage;
  WishlistProductsState(
      {required this.wishProducts, required this.errorMessage});
}

class WishlistProductsInitial extends WishlistProductsState {
  WishlistProductsInitial() : super(wishProducts: [], errorMessage: "");
}
