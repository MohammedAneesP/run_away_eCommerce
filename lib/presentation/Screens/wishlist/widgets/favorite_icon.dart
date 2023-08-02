import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/wishlist/fav_icon/fav_icon_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';

class FavoriteIcon extends StatelessWidget {
  FavoriteIcon({
    super.key,
    required this.anEmil,
    required this.anProductId,
  });

  final String anEmil;
  final String anProductId;

  final fireUser = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavIconBloc, FavIconState>(
      builder: (context, state) {
        return state.anFavList.contains(anProductId)
            ? CircleAvatar(
              child: IconButton(
                  onPressed: () {
                    BlocProvider.of<FavIconBloc>(context).add(FavProductDelete(
                        anEmail: anEmil, anProduct: anProductId));
                        snackBar(context, "Removed from Wishlist 💔");
                  },
                  icon: const Icon(CupertinoIcons.heart,color:kRed,)),
            )
            : CircleAvatar(
              
              child: IconButton(
                  onPressed: () {
                    BlocProvider.of<FavIconBloc>(context).add(FavProductAdding(
                        anEmail: anEmil, anProduct: anProductId));
                        snackBar(context, "Added to Wishlist 💖");
                  },
                  icon: const Icon(CupertinoIcons.heart)),
            );
      },
    );
  }
}
