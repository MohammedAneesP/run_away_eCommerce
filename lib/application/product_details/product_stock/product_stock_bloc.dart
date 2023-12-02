
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'product_stock_event.dart';
part 'product_stock_state.dart';

class ProductStockBloc extends Bloc<ProductStockEvent, ProductStockState> {
  ProductStockBloc() : super(ProductStockInitial()) {
    on<UpdatingProduct>((event, emit) async {
      final products =
          await FirebaseFirestore.instance.collection("products").get();
      final theProducts = products.docs;
      if (theProducts.isEmpty) {
        return emit(ProductStockState(
            errorMesssage: "Something went Wrong", successMessage: ""));
      } else {
        final updateProducts = theProducts.where((element) {
          return event.anStockSizeCount.containsKey(element.id);
        }).toList();
        Map<String, dynamic> forStockAndSize = {};
        for (var element in updateProducts) {
          forStockAndSize[element.id] = element.data();
        }
        forStockAndSize.forEach((key, value) {
          Map<String, dynamic> anSize = forStockAndSize[key]["stockAndSize"];

          final theCount =
              int.parse(anSize[event.anStockSizeCount[key]["size"]]);
          final toless = int.parse(event.anStockSizeCount[key]["count"]);
         
          final theDecreased = theCount - toless;
          anSize[event.anStockSizeCount[key]["size"]] = theDecreased.toString();
          
          forStockAndSize[key]["stockAndSize"] = anSize;
          FirebaseFirestore.instance
              .collection("products")
              .doc(key)
              .set(forStockAndSize[key]);
        });
      }
    });
  }
}
