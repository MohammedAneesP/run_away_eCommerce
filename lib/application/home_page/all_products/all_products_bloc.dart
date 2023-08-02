import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc() : super(AllProductsInitial()) {
    on<AllProductListing>((event, emit) async {
      final anData =
          await FirebaseFirestore.instance.collection("products").get();
      final allProducts = anData.docs;
      if (allProducts.isEmpty) {
        return emit(
            AllProductsState(allProducts: [], errorMessage: "no products"));
      } else {
        return emit(
            AllProductsState(allProducts: allProducts, errorMessage: ""));
      }
    });
  }
}
