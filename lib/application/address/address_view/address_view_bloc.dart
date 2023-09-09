import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'address_view_event.dart';
part 'address_view_state.dart';

class AddressViewBloc extends Bloc<AddressViewEvent, AddressViewState> {
  AddressViewBloc() : super(AddressViewInitial()) {
    on<ViewingAddresses>((event, emit) async {
      try {
        final carts = await FirebaseFirestore.instance
            .collection("cart")
            .doc(event.anEmail)
            .get();
        if (carts.exists) {
          final cartValue = carts.data();
          if (cartValue!.isEmpty) {
            return emit(AddressViewState(
                addresses: {},
                anErrorMessage: "nothing Added to cart",
                cart: {},
                products: []));
          } else {
            final products =
                await FirebaseFirestore.instance.collection("products").get();
            if (products.docs.isEmpty) {
              log("empty");
              return emit(AddressViewState(
                  addresses: {},
                  anErrorMessage: "Unexpected  error",
                  cart: {},
                  products: []));
            } else {
              final forProducts = products.docs;
              final theCartProducts = forProducts.where((element) {
                return cartValue.containsKey(element.id);
              }).toList();
              log(theCartProducts.toString());
              final address = await FirebaseFirestore.instance
                  .collection("address")
                  .doc(event.anEmail)
                  .get();
              if (address.exists) {
                final addresses = address.data();
                if (addresses!.isEmpty) {
                  return emit(AddressViewState(
                    addresses: {},
                    anErrorMessage: "address not added",
                    cart: cartValue,
                    products: theCartProducts,
                  ));
                } else {
                  return emit(AddressViewState(
                    addresses: addresses,
                    anErrorMessage: "",
                    cart: cartValue,
                    products: theCartProducts,
                  ));
                }
              } else {
                return emit(AddressViewState(
                  addresses: {},
                  anErrorMessage: "address not added",
                  cart: cartValue,
                  products: theCartProducts,
                ));
              }
            }
          }
        } else {
          return emit(AddressViewState(
              addresses: {},
              anErrorMessage: "nothing Added to cart",
              cart: {},
              products: []));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
