import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_view_event.dart';
part 'cart_view_state.dart';

class CartViewBloc extends Bloc<CartViewEvent, CartViewState> {
  CartViewBloc() : super(CartViewInitial()) {
    on<ProductsInCart>((event, emit) async {
      try {
        final anValue = await FirebaseFirestore.instance
            .collection("cart")
            .doc(event.anEmail)
            .get();
        if (anValue.exists) {
          final anData = anValue.data();
          if (anData!.isEmpty) {
            return emit(CartViewState(
                cartProducts: [],
                errorMessage: "No product Added to Cart",
                anProductSize: {}));
          } else {
            final product =
                await FirebaseFirestore.instance.collection("products").get();
            final products = product.docs;
            if (products.isEmpty) {
              return emit(CartViewState(
                  cartProducts: [],
                  errorMessage: "No product Added to Cart",
                  anProductSize: {}));
            } else {
              final theCartProducts = products.where((element) {
                return anData.containsKey(element.id);
              }).toList();
              return emit(CartViewState(
                  cartProducts: theCartProducts,
                  errorMessage: "",
                  anProductSize: anData));
            }
          }
        } else {
          return emit(CartViewState(
              cartProducts: [],
              errorMessage: "No product Added to Cart",
              anProductSize: {}));
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<CartUpdatingCount>((event, emit) async {
      final anData = await FirebaseFirestore.instance
          .collection("cart")
          .doc(event.anEmail)
          .get();
      if (anData.exists) {
        final products = anData.data();
        if (products!.isEmpty) {
          return emit(CartViewState(
              cartProducts: [],
              errorMessage: "nothing to Disply",
              anProductSize: {}));
        } else {
          await FirebaseFirestore.instance
              .collection("cart")
              .doc(event.anEmail)
              .set(event.anUpdateMap);
          final forProducts =
              await FirebaseFirestore.instance.collection("products").get();
          final pros = forProducts.docs;

          if (pros.isEmpty) {
            return emit(CartViewState(
                cartProducts: [],
                errorMessage: "nothing to Display",
                anProductSize: {}));
          } else {
            final theList = pros.where((element) {
              return event.anUpdateMap.containsKey(element.id);
            }).toList();
            return emit(CartViewState(
                cartProducts: theList,
                errorMessage: "",
                anProductSize: event.anUpdateMap));
          }
        }
      } else {
        return emit(CartViewState(
            cartProducts: [],
            errorMessage: "nothing to Display",
            anProductSize: {}));
      }
    });
    on<CartItemRemove>((event, emit) async {
      final anData = await FirebaseFirestore.instance
          .collection("cart")
          .doc(event.anEmail)
          .get();
      if (anData.exists) {
        final anValue = anData.data();
        if (anValue!.isEmpty) {
          return emit(CartViewState(
              cartProducts: [],
              errorMessage: "No product Added to Cart",
              anProductSize: {}));
        } else {
          anValue.remove(event.anProductId);
          final allProducts =
              await FirebaseFirestore.instance.collection("products").get();
          final products = allProducts.docs;
          if (products.isEmpty) {
            return emit(CartViewState(
                cartProducts: [],
                errorMessage: "No product Added to Cart",
                anProductSize: {}));
          } else {
            final theProducts = products.where((element) {
              return anValue.containsKey(element.id);
            }).toList();
            await FirebaseFirestore.instance
                .collection("cart")
                .doc(event.anEmail)
                .set(anValue);
            return emit(CartViewState(
                cartProducts: theProducts,
                errorMessage: "",
                anProductSize: anValue));
          }
        }
      } else {
        return emit(CartViewState(
            cartProducts: [],
            errorMessage: "No product Added to Cart",
            anProductSize: {}));
      }
    });
  }
}
