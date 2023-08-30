// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:run_away/application/cart/cart_button_bloc/cart_button_bloc.dart';
// import 'package:run_away/core/color_constants/colors.dart';
// import 'package:run_away/core/constants/constants.dart';
// import 'package:run_away/core/text_constants/constants.dart';
// import 'package:run_away/presentation/Screens/cart/my_cart.dart';
// import 'package:run_away/presentation/Screens/product_details/product_view.dart';

// class AddToCartButton extends StatelessWidget {
//   final String anEmail;
//   final String anProductId;
//   final String anSelectedSize;
//   const AddToCartButton({
//     super.key,
//     required this.anEmail,
//     required this.anProductId,
//     required this.anSelectedSize,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartButtonBloc, CartButtonState>(
//       builder: (context, state) {
//         return state.productId.containsKey(anProductId)
//             ? ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MyCart(),
//                       ));
//                 },
//                 style: const ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(kBlue),
//                   shape: MaterialStatePropertyAll(StadiumBorder()),
//                 ),
//                 child: Text(
//                   "Go to Cart",
//                   style: buttontextWhite,
//                 ))
//             : ElevatedButton(
//                 onPressed: () {
//                   if (anSelectVal.value < 0) {
//                     log("message");
//                     snackBar(context, "Please Select an Size");
//                     return;
//                   }
//                   BlocProvider.of<CartButtonBloc>(context).add(AddingToCart(
//                       anProductId: anProductId.toString(),
//                       anEmail: anEmail,
//                       anSelectedIndex: anSize.value.toString()));
//                   changeValue(-1, '');
//                 },
//                 style: const ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(kBlue),
//                   shape: MaterialStatePropertyAll(StadiumBorder()),
//                 ),
//                 child: Text(
//                   "Add to cart",
//                   style: buttontextWhite,
//                 ));
//       },
//     );
//   }
// }
