import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'seearch_product_event.dart';
part 'seearch_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  SearchProductBloc() : super(SearchProductInitial()) {
    on<SearchResult>((event, emit) async {
      final allProducts =
          await FirebaseFirestore.instance.collection("products").get();
      final products = allProducts.docs;
      final allBrands =
          await FirebaseFirestore.instance.collection("brands").get();
      final brands = allBrands.docs;
      List<dynamic> emitBrands = [];
      List<dynamic> emitProducts = [];
      final String anQuery = event.query.toUpperCase();
      if (products.isEmpty) {
        return emit(
            SearchProductState(allProductsList: [], searchProducts: []));
      } else if (brands.isEmpty) {
        return emit(
            SearchProductState(allProductsList: [], searchProducts: []));
      } else {
        if (anQuery.isNotEmpty) {
          emitProducts = products.where((element) {
            final anProductName = element["itemName"].toString().toUpperCase();
            return anProductName.contains(anQuery);
          }).toList();
          emitBrands = brands.where((element) {
            final anBrandName = element["brandName"].toString().toUpperCase();
            return anBrandName.contains(anQuery);
          }).toList();
          final List<dynamic> brandIds = [];
          for (var element in emitBrands) {
            brandIds.add(element["brandId"]);
          }
          for (var i = 0; i < products.length; i++) {
            if (brandIds.contains(products[i]["brandId"])) {
              log("_______");
              emitProducts.add(products[i]);
            }
          }

          for (var element in emitProducts) {
            log(element["itemName"].toString());
          }
          if (emitProducts.isEmpty) {
            return emit(
                SearchProductState(allProductsList: [], searchProducts: []));
          } else {
            return emit(SearchProductState(
                allProductsList: products, searchProducts: emitProducts));
          }
        } else {
          return emit(SearchProductState(
              allProductsList: products, searchProducts: []));
        }
      }
    });
  }
}
