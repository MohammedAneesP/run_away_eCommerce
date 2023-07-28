import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'popular_product_event.dart';
part 'popular_product_state.dart';

class PopularProductBloc
    extends Bloc<PopularProductEvent, PopularProductState> {
  PopularProductBloc() : super(PopularProductInitial()) {
    on<SomeProduct>((event, emit) async {
      final anData =
          await FirebaseFirestore.instance.collection("products").get();
      final products = anData.docs;
      if (products.isEmpty) {
        return emit(
            PopularProductState(theProducts: [], errorMessage: "No products"));
      } else {
        
        final randomList = List.from(products);
        //randomList.shuffle();
        randomList.length = 3;
        return emit(
            PopularProductState(theProducts: randomList, errorMessage: ""));
      }
    });
  }
}
