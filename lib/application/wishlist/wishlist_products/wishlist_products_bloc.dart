import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:run_away/application/wishlist/fav_icon/fav_icon_bloc.dart';

part 'wishlist_products_event.dart';
part 'wishlist_products_state.dart';

class WishlistProductsBloc
    extends Bloc<WishlistProductsEvent, WishlistProductsState> {
  WishlistProductsBloc() : super(WishlistProductsInitial()) {
    on<WishProductList>((event, emit) async {
      try {
        final List<dynamic> toEmitFav = [];
        final fullProducts =
            await FirebaseFirestore.instance.collection("products").get();
        if (fullProducts.docs.isEmpty) {
          return emit(WishlistProductsState(
              wishProducts: [], errorMessage: "product not added"));
        } else {
          final products = fullProducts.docs;
          if (products.isEmpty) {
            return emit(WishlistProductsState(
                wishProducts: [], errorMessage: "product not added"));
          } else {
            for (var element in products) {
              if (anFavList.contains(element["productId"])) {
                toEmitFav.add(element);
                //log(toEmitFav.toString());
              }
            }
            return emit(WishlistProductsState(
                wishProducts: toEmitFav, errorMessage: "product not added"));
          }
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<RemoveFavorite>((event, emit) async {
      final List<dynamic> toEmitFav = [];
      try {
        final fullProducts =
            await FirebaseFirestore.instance.collection("products").get();
        final allProducts = fullProducts.docs;
        if (allProducts.isEmpty) {
          return emit(WishlistProductsState(
              wishProducts: [], errorMessage: "No products"));
        } else {
          anFavList.remove(event.anProductId);
          for (var element in allProducts) {
            if (anFavList.contains(element["productId"])) {
              toEmitFav.add(element);
            }
          }
          await FirebaseFirestore.instance
              .collection("users")
              .doc(event.anEmail)
              .set({"favorites": anFavList});
          return emit(
              WishlistProductsState(wishProducts: toEmitFav, errorMessage: ""));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
