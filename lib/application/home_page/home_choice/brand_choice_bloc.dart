import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'brand_choice_event.dart';
part 'brand_choice_state.dart';

class BrandChoiceBloc extends Bloc<BrandChoiceEvent, BrandChoiceState> {
  BrandChoiceBloc() : super(BrandChoiceInitial()) {
    on<DisplayBrand>((event, emit)async {
      final anData = await FirebaseFirestore.instance.collection("brands").get();
      final brands =  anData.docs;
      if (brands.isEmpty) {
        return emit(BrandChoiceState(theBrands: [], errorMessage: "no brands available"));
      }else{
        return emit(BrandChoiceState(theBrands: brands, errorMessage: ""));
      }
    });
  }
}
