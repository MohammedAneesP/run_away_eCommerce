part of 'brand_choice_bloc.dart';

class BrandChoiceState {
  final String errorMessage;
  final List<dynamic> theBrands;
  BrandChoiceState({required this.theBrands, required this.errorMessage});
}

class BrandChoiceInitial extends BrandChoiceState {
  BrandChoiceInitial() : super(theBrands: [], errorMessage: '');
}
