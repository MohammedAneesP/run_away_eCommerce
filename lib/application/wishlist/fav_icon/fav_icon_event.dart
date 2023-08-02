part of 'fav_icon_bloc.dart';

@immutable
abstract class FavIconEvent {}

class FavProduct extends FavIconEvent {
  final String anEmail;
  FavProduct({required this.anEmail});
}

class FavProductAdding extends FavIconEvent{
  final String anEmail;
  final String anProduct;
  FavProductAdding({required this.anEmail,required this.anProduct});
}

class FavProductDelete extends FavIconEvent {
  final String anEmail;
  final String anProduct;
  FavProductDelete({required this.anProduct,required this.anEmail});
}
