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
          final theData = anValue.data();
          if (theData!.isEmpty) {
            return emit(CartButtonState(
                productId: {}, errorMessage: "nothing added yet"));
          } else {
            return emit(CartButtonState(productId: theData, errorMessage: ""));
          }
        } else {
          return emit(CartButtonState(
              productId: {}, errorMessage: "nothing added yet"));
        }
      } catch (e) {
        log("___________");
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
          final anData = anValue.data();
          if (anData!.isEmpty) {
            final idAndSize = {event.anProductId: event.anSelectedIndex};
            await FirebaseFirestore.instance
                .collection("cart")
                .doc(event.anEmail)
                .set({event.anProductId.toString(): event.anSelectedIndex});
            return emit(
                CartButtonState(productId: idAndSize, errorMessage: ''));
          } else {
            Map<String,dynamic> idAndSize = {};
            idAndSize.addAll(anData);
            idAndSize.addAll({event.anProductId.toString(): event.anSelectedIndex});
            await FirebaseFirestore.instance.collection("cart").doc(event.anEmail).set(idAndSize);
            return emit(CartButtonState(productId: idAndSize, errorMessage: ""));
          }
        } else {
          final idAndSize = {event.anProductId: event.anSelectedIndex};
          log(idAndSize.toString());
          await FirebaseFirestore.instance
              .collection("cart")
              .doc(event.anEmail)
              .set({event.anProductId.toString(): event.anSelectedIndex});
          return emit(CartButtonState(productId: idAndSize, errorMessage: ''));
        }
      } catch (e) {
        log("aavanillla");
        log(e.toString());
      }
    });
  }
}
