import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'product_in_brand_event.dart';
part 'product_in_brand_state.dart';

class ProductInBrandBloc extends Bloc<ProductInBrandEvent, ProductInBrandState> {
  ProductInBrandBloc() : super(ProductInBrandInitial()) {
    on<TheProducts>((event, emit)async
     {
      final product =await FirebaseFirestore.instance.collection("products").get();
      final anData = product.docs;
      if (anData.isEmpty) {
        return emit(ProductInBrandState(products: [], errorMessage: "no product exist"));
      }
      else{
       final theProducts = anData.where((element) {
        final anProduct = element["brandId"].toString();
        return anProduct.contains(event.anProductId);
       }).toList();
       
      return emit(ProductInBrandState(products: theProducts, errorMessage: ""));
      }
    });
  }
}
