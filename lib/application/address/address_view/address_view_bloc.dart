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
