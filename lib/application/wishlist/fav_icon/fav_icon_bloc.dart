import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fav_icon_event.dart';
part 'fav_icon_state.dart';


List<dynamic> anFavList = [];
class FavIconBloc extends Bloc<FavIconEvent, FavIconState> {
  FavIconBloc() : super(FavIconInitial()) {
    on<FavProduct>((event, emit) async {
      try {
        final anValue = await FirebaseFirestore.instance
          .collection("users")
          .doc(event.anEmail)
          .get();
      final anData = anValue.data() ?? {};
      if (anData.isEmpty) {
        return emit(FavIconState(anFavList: []));
      } else {
        final List<dynamic> anList = [];
        for (var element in anData["favorites"]) {
          anList.add(element.toString());
        }
        anFavList = anList;
        //log(anFavList.toString());
        return emit(FavIconState(anFavList: anList));
      }
      } catch (e) {
       log(e.toString());
      }
      
    });

    on<FavProductAdding>((event, emit) async {
      try {
        final anValue = await FirebaseFirestore.instance
          .collection("users")
          .doc(event.anEmail)
          .get();
      final anData = anValue.data() ?? {};
      if (anData.isEmpty) {
        return emit(FavIconState(anFavList: []));
      } else {
        final List<dynamic> anList = [];
        for (var element in anData["favorites"]) {
          anList.add(element.toString());
        }
        anList.add(event.anProduct);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(event.anEmail)
            .set({"favorites": anList});
            anFavList.clear();
            anFavList = anList;
        return emit(FavIconState(anFavList: anList));
      }
      } catch (e) {
        log(e.toString());
      }
      
    });

    on<FavProductDelete>((event, emit) async {
      try {
         final anValue = await FirebaseFirestore.instance
          .collection("users")
          .doc(event.anEmail)
          .get();
      final anData = anValue.data() ?? {};
      if (anData.isEmpty) {
        return emit(FavIconState(anFavList: []));
      } else {
        final List<dynamic> anList = [];
        for (var element in anData["favorites"]) {
          anList.add(element.toString());
        }
        anList.remove(event.anProduct);
         await FirebaseFirestore.instance
            .collection("users")
            .doc(event.anEmail)
            .set({"favorites": anList});
            anFavList.clear();
            anFavList = anList;
        return emit(FavIconState(anFavList: anList));
      }
      } catch (e) {
        log(e.toString());
      }
     
    });
  }
}
