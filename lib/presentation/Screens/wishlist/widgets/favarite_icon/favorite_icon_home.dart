import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/wishlist/fav_icon/fav_icon_bloc.dart';
import 'package:run_away/application/wishlist/wishlist_products/wishlist_products_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';

class FavoriteIconHome extends StatelessWidget {
  FavoriteIconHome({
    super.key,
    required this.anEmail,
    required this.anProductId,
  });

  final String anEmail;
  final String anProductId;
  final fireName = FirebaseAuth.instance.currentUser;
  final fireUser = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavIconBloc, FavIconState>(
      builder: (context, state) {
        return state.anFavList.contains(anProductId)
            ? CircleAvatar(
                child: IconButton(
                    onPressed: () async {
                      BlocProvider.of<FavIconBloc>(context).add(
                          FavProductDelete(
                              anEmail: anEmail, anProduct: anProductId));
                      BlocProvider.of<WishlistProductsBloc>(context).add(
                          RemoveFavorite(
                              anProductId: anProductId, anEmail: anEmail));
                      showCircleProgress(context);
                      await Future.delayed(const Duration(seconds: 1));
                      if (context.mounted) {
                        Navigator.pop(context);
                        snackBar(context, "Removed from Wishlist 💔");
                      }
                    },
                    icon: const Icon(CupertinoIcons.heart, color: kRed)),
              )
            : CircleAvatar(
                child: IconButton(
                    onPressed: () async {
                      BlocProvider.of<FavIconBloc>(context).add(
                          FavProductAdding(
                              anEmail: anEmail, anProduct: anProductId));
                      BlocProvider.of<FavIconBloc>(context)
                          .add(FavProduct(anEmail: fireName!.email.toString()));
                      
                      BlocProvider.of<WishlistProductsBloc>(context).add(
                          WishProductList(anEmail: fireName!.email.toString()));
                      showCircleProgress(context);
                      await Future.delayed(const Duration(seconds: 1));
                      if (context.mounted) {
                        Navigator.pop(context);
                        snackBar(context, "Added to Wishlist 💖");
                      }
                    },
                    icon: const Icon(CupertinoIcons.heart)),
              );
      },
    );
  }
}
