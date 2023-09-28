import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'an_order_details_event.dart';
part 'an_order_details_state.dart';

class AnOrderDetailsBloc
    extends Bloc<AnOrderDetailsEvent, AnOrderDetailsState> {
  AnOrderDetailsBloc() : super(AnOrderDetailsInitial()) {
    on<DisplayAnOerder>((event, emit) async {
      final anData = await FirebaseFirestore.instance
          .collection("products")
          .doc(event.anProductKey)
          .get();
      if (anData.exists) {
        final oneProduct = anData.data();
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
    on<DisplayOrderClearing>((event, emit) {
      return emit(
          AnOrderDetailsState(anOrder: {}, anProduct: {}, isLoading: false));
    });
  }
}
