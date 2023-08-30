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
        final anValue = await FirebaseFirestore.instance.collection("cart").doc(event.anEmail).get();
        if (anValue.exists) {
          final anData = anValue.data();
          if (anData!.isEmpty) {
            return emit(CartViewState(cartProducts: [], errorMessage: "No product Added to Cart"));
          }else{
            final product = await FirebaseFirestore.instance.collection("products").get();
            final products = product.docs;
            if (products.isEmpty) {
               return emit(CartViewState(cartProducts: [], errorMessage: "No product Added to Cart"));
            }else{
              final theCartProducts = products.where((element) {
                return anData.containsKey(element.id);
              }).toList();
              return emit(CartViewState(cartProducts: theCartProducts, errorMessage: ""));
            }
          }
        }
        else{
          return emit(CartViewState(cartProducts: [], errorMessage: "No product Added to Cart"));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
