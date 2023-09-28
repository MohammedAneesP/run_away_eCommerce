import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'displaying_all_orders_event.dart';
part 'displaying_all_orders_state.dart';

class DisplayingAllOrdersBloc
    extends Bloc<DisplayingAllOrdersEvent, DisplayingAllOrdersState> {
  DisplayingAllOrdersBloc() : super(DisplayingAllOrdersInitial()) {
    on<OrdersDisplaying>((event, emit) async {
      try {
        final anValue =
            await FirebaseFirestore.instance.collection("orders").get();
        final theOrders = anValue.docs;
        if (theOrders.isEmpty) {
          return emit(DisplayingAllOrdersState(
              userOrders: [], products: {}, isLoading: true, orders: {}));
        } else {
          Map<String, dynamic> entireOrders = {};
          final orders = theOrders.where((element) {
            return event.anEmail.contains(element["emailKey"]);
          }).toList();
          List <dynamic> forAllOrders=[];
          List<dynamic> wholeOrders = [];
          for (var element in orders) {
            entireOrders[element.id] = element.data();
            Map<String, dynamic> anMap = {};
            anMap = element["products"];
            anMap.forEach((key, value) {
              wholeOrders.add({key: element.id.toString()});
            });
          }
          final forProducts =
              await FirebaseFirestore.instance.collection("products").get();
          final products = forProducts.docs;
          if (products.isEmpty) {
            return emit(DisplayingAllOrdersState(
              orders: {},
              userOrders: [],
              products: {},
              isLoading: true,
            ));
          } else {
            Map<String, dynamic> forProducts = {};
            for (var element in products) {
              forProducts[element.id.toString()] = element.data();
            }
            forAllOrders = wholeOrders.reversed.toList();
            return emit(DisplayingAllOrdersState(
              orders: entireOrders,
              userOrders: forAllOrders,
              products: forProducts,
              isLoading: false,
            ));
          }
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
