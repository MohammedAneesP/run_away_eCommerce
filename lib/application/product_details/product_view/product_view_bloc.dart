import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'product_view_event.dart';
part 'product_view_state.dart';

class ProductViewBloc extends Bloc<ProductViewEvent, ProductViewState> {
  ProductViewBloc() : super(ProductViewInitial()) {
    on<AnProductView>((event, emit) async {
      try {
        final anData = await FirebaseFirestore.instance
            .collection("products")
            .doc(event.anProductid)
            .get();
        if (anData.exists) {
          final anProduct = anData.data();
          if (anProduct!.isEmpty) {
            return emit(ProductViewState(
                products: {}, errorMessage: "there is no such Product"));
          } else {
            return emit(
                ProductViewState(products: anProduct, errorMessage: ""));
          }
        } else {
          return emit(ProductViewState(
              products: {}, errorMessage: "there is no such Product"));
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<ProductClear>((event, emit) {
      return emit(ProductViewState(
          products: {}, errorMessage: "there is no such Product"));
    });
  }
}
