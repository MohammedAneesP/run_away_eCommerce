import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/order/an_order_details/an_order_details_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';

class AnOrderAppBarLeading extends StatelessWidget {
  const AnOrderAppBarLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: kWhite,
        child: IconButton(
          onPressed: () {
            BlocProvider.of<AnOrderDetailsBloc>(context)
                .add(DisplayOrderClearing());
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: kBlack,
          ),
        ),
      ),
    );
  }
}