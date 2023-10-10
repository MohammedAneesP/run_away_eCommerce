import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'ordering_on_success_event.dart';
part 'ordering_on_success_state.dart';

class OrderingOnSuccessBloc
    extends Bloc<OrderingOnSuccessEvent, OrderingOnSuccessState> {
  OrderingOnSuccessBloc() : super(OrderingOnSuccessInitial()) {
    on<AddToOrders>((event, emit) async {
      try {
        final anValue = await FirebaseFirestore.instance
            .collection("cart")
            .doc(event.anEmail)
            .get();
        if (anValue.exists) {
          final anCart = anValue.data();
          if (anCart!.isEmpty) {
            return emit(OrderingOnSuccessState(
                anEmail: "",
                anAddressKey: "",
                errorMessage: "Something Went Wrong",
                shippingCharge: ""));
          } else {
            final forAddress = await FirebaseFirestore.instance
                .collection("address")
                .doc(event.anEmail)
                .get();
            if (forAddress.exists) {
              final theAddresses = forAddress.data();
              if (theAddresses!.isEmpty) {
                return emit(OrderingOnSuccessState(
                    anEmail: "",
                    anAddressKey: "",
                    errorMessage: "Something Went Wrong",
                    shippingCharge: ""));
              } else {
                Map<String, dynamic> anAddress = {};
                anAddress = theAddresses[event.selectedAddressKey];

                Map<String, dynamic> order = {};
                Map<String, dynamic> products = {};

                final timeNow = DateTime.now().toString();
                order["products"] = products;
                anCart.forEach((key, value) {
                  order["products"][key] = value;
                  order["products"][key]["status"] = "order placed";
                });

                anAddress.forEach((key, value) {
                  order["address"] ??= {};
                  order["address"][key] = value;
                });

                order["shippingCost"] = event.shippingCharge;
                order["emailKey"] = event.anEmail;
                order["documentId"] = timeNow.toString();

                await FirebaseFirestore.instance
                    .collection("orders")
                    .doc(timeNow)
                    .set(order);
                await FirebaseFirestore.instance
                    .collection("cart")
                    .doc(event.anEmail)
                    .delete();
                    
                return emit(OrderingOnSuccessState(
                    anEmail: event.anEmail,
                    anAddressKey: event.selectedAddressKey,
                    errorMessage: "Done",
                    shippingCharge: event.shippingCharge));
              }
            } else {
              return emit(OrderingOnSuccessState(
                  anEmail: "",
                  anAddressKey: "",
                  errorMessage: "Something Went Wrong",
                  shippingCharge: ""));
            }
          }
        } else {
          return emit(OrderingOnSuccessState(
              anEmail: "",
              anAddressKey: "",
              errorMessage: "Something Went Wrong",
              shippingCharge: ""));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
