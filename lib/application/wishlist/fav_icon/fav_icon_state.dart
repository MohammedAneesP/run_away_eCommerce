part of 'fav_icon_bloc.dart';

 class FavIconState {
 final List<dynamic> anFavList;
 FavIconState({required this.anFavList}); 
}

class FavIconInitial extends FavIconState {
  FavIconInitial():super(anFavList: []);
}
