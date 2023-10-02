import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'an_order_details_event.dart';
part 'an_order_details_state.dart';

class AnOrderDetailsBloc
    extends Bloc<AnOrderDetailsEvent, AnOrderDetailsState> {
  AnOrderDetailsBloc() : super(AnOrderDetailsInitial()) {
    on<DisplayAnOerder>((event, emit) async {
      final anProduct = await FirebaseFirestore.instance
          .collection("products")
          .doc(event.anProductKey)
          .get();
      if (anProduct.exists) {
        final oneProduct = anProduct.data();
        if (oneProduct!.isEmpty) {
          return emit(AnOrderDetailsState(
              anOrder: {}, anProduct: {}, isLoading: false));
        }
        final anOrder = await FirebaseFirestore.instance
            .collection("orders")
            .doc(event.anOrderKey)
            .get();
        if (anOrder.exists) {
          final oneOrder = anOrder.data();
          if (oneOrder!.isEmpty) {
            return emit(AnOrderDetailsState(
                anOrder: {}, anProduct: {}, isLoading: false));
          } else {
            return emit(AnOrderDetailsState(
                anOrder: oneOrder, anProduct: oneProduct, isLoading: true));
          }
        } else {
          return emit(AnOrderDetailsState(
              anOrder: {}, anProduct: {}, isLoading: false));
        }
      } else {
        return emit(
            AnOrderDetailsState(anOrder: {}, anProduct: {}, isLoading: false));
      }
    });
    on<CancellingOrder>((event, emit) async {
      try {
        final anOrder = await FirebaseFirestore.instance
            .collection("orders")
            .doc(event.anOrderKey)
            .get();
        if (anOrder.exists) {
          final theOrder = anOrder.data();
          if (theOrder!.isEmpty) {
            return emit(AnOrderDetailsState(
                anOrder: {}, anProduct: {}, isLoading: false));
          } else {
            Map<String, dynamic> products = {};
            products = theOrder["products"];
            log(products.toString());
            products[event.anProductKey]["status"] = "cancelled";
            theOrder["products"] = products;
            log(theOrder.toString());
            await FirebaseFirestore.instance
                .collection("orders")
                .doc(event.anOrderKey)
                .set(theOrder);
            final anProduct = await FirebaseFirestore.instance
                .collection("products")
                .doc(event.anProductKey)
                .get();
            if (anProduct.exists) {
              final product = anProduct.data();
              if (product!.isEmpty) {
                return emit(AnOrderDetailsState(
                    anOrder: {}, anProduct: {}, isLoading: false));
              } else {
                return emit(AnOrderDetailsState(
                    anOrder: theOrder, anProduct: product, isLoading: true));
              }
            } else {
              return emit(AnOrderDetailsState(
                  anOrder: {}, anProduct: {}, isLoading: false));
            }
          }
        } else {
          return emit(AnOrderDetailsState(
              anOrder: {}, anProduct: {}, isLoading: false));
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<DisplayOrderClearing>((event, emit) {
      return emit(
          AnOrderDetailsState(anOrder: {}, anProduct: {}, isLoading: false));
    });
  }
}
