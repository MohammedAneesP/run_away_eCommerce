import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/bottom_nav/bottom_nav.dart';
import 'package:run_away/presentation/Screens/orders/my_orders.dart';

const kSpace50 = SizedBox(
  height: 50,
);

void snackBar(BuildContext context, String aText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: const StadiumBorder(),
      content: Center(
        child: Text(
          aText,
        ),
      ),
    ),
  );
}

void anSnackBarFunc(
    {required BuildContext context,
    required String aText,
    required Color anColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(aText),
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      backgroundColor: anColor,
    ),
  );
}

class PaymentSuccessWidget extends StatelessWidget {
  const PaymentSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return SizedBox(
      height: kHeight.height * 0.35,
      child: LottieBuilder.asset(
        "assets/animation_lnfmvkl2.json",
        height: kHeight.height * 0.2,
        width: kWidth.width * 1,
      ),
    );
  }
}

void showPaymentSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Payment successful!'),
        content: const PaymentSuccessWidget(),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavPage(),
                  ));
            },
            child: Text('Continue shopping', style: kBlueText),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOrders(),
                  ));
            },
            child: Text('Show Orders', style: kBlueText),
          ),
        ],
      );
    },
  );
}

Future<dynamic> showCircleProgress(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
