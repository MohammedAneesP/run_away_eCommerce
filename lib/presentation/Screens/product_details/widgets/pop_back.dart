
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/product_details/product_view/product_view_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';

class PopBackButton extends StatelessWidget {
  const PopBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: kWhite,
        child: IconButton(
            onPressed: () {
              BlocProvider.of<ProductViewBloc>(context).add(ProductClear());
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back)),
      ),
    );
  }
}
