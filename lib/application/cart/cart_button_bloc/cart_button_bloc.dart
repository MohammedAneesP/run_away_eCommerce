import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_button_event.dart';
part 'cart_button_state.dart';

class CartButtonBloc extends Bloc<CartButtonEvent, CartButtonState> {
  CartButtonBloc() : super(CartButtonInitial()) {
    on<CartProducts>((event, emit) async {
      try {
        final anValue = await FirebaseFirestore.instance
            .collection("cart")
            .doc(event.anEmail)
            .get();
        if (anValue.exists) {
          final anData = anValue.data() ?? {};
          if (anData.isEmpty) {
            return emit(CartButtonState(
                productId: [], errrorMessage: "nothing added to Cart"));
          }
          final List<dynamic> fullCart = [];
          for (var element in anData["productId"]) {
            fullCart.add(element.toString());
          }
          return emit(CartButtonState(productId: fullCart, errrorMessage: ""));
        } else {
          return emit(CartButtonState(
              productId: [], errrorMessage: "nothing added to Cart"));
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<AddingToCart>((event, emit) async {
      try {
        final anValue = await FirebaseFirestore.instance
            .collection("cart")
            .doc(event.anEmail)
            .get();
        if (anValue.exists) {
          final anData = anValue.data() ?? {};
          if (anData.isEmpty) {
            final List<dynamic> forCart = [];
            forCart.add(event.anProductId);
            await FirebaseFirestore.instance
                .collection("cart")
                .doc(event.anEmail)
                .set({"productId": forCart});
            return emit(CartButtonState(productId: forCart, errrorMessage: ""));
          } else {
            final List<dynamic> forCart = [];
            for (var element in anData["productId"]) {
              forCart.add(element.toString());
            }
            forCart.add(event.anProductId);
            await FirebaseFirestore.instance
                .collection("cart")
                .doc(event.anEmail)
                .set({"productId": forCart});
            return emit(CartButtonState(productId: forCart, errrorMessage: ""));
          }
        } else {
          final List<dynamic> forCart = [];
          forCart.add(event.anProductId);
          await FirebaseFirestore.instance
              .collection("cart")
              .doc(event.anEmail)
              .set({"productId": forCart});
          return emit(CartButtonState(productId: forCart, errrorMessage: ""));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
