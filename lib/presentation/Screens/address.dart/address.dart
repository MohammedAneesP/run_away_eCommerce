
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_away/application/address/address_dropdown/dropdown_address_bloc.dart';
import 'package:run_away/application/address/address_view/address_view_bloc.dart';
import 'package:run_away/application/address/payment_choice_dropdown/payment_choice_drop_bloc.dart';
import 'package:run_away/application/order/ordering_on_success/ordering_on_success_bloc.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/address.dart/adding_address/addres_adding.dart';
import 'package:run_away/presentation/Screens/address.dart/widgets/payments_dropdown.dart';
import 'package:run_away/presentation/Screens/cart/widgets/cart_product_img.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:run_away/presentation/Screens/home_page/home_page.dart';

import 'widgets/dropdown_address.dart';
import 'widgets/email_phone_tile.dart';
import 'widgets/no_address_addedtile.dart';
import 'widgets/no_address_bottomsheet.dart';

String anSelectedAddress = "";

String paymentChoice = "";

class AddressSelecting extends StatefulWidget {
  const AddressSelecting({super.key});

  @override
  State<AddressSelecting> createState() => _AddressSelectingState();
}

class _AddressSelectingState extends State<AddressSelecting> {
  final _razorpay = Razorpay();

  final fireName = FirebaseAuth.instance.currentUser;

  ValueNotifier<String> numberNotify = ValueNotifier("");

  ValueNotifier<String> emailNotify = ValueNotifier("");

  ValueNotifier<int> shipping = ValueNotifier(150);

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    BlocProvider.of<OrderingOnSuccessBloc>(context).add(AddToOrders(
        anEmail: fireName!.email.toString(),
        selectedAddressKey: anSelectedAddress,
        shippingCharge: shipping.value.toString()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddressViewBloc>(context)
        .add(ViewingAddresses(anEmail: fireName!.email.toString()));
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);

    return BlocBuilder<AddressViewBloc, AddressViewState>(
      builder: (context, state) {
        if (state.products.isEmpty) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {
          if (state.addresses.isEmpty) {
            int subtotal = 0;

            int totalCost = 0;
            for (var i = 0; i < state.products.length; i++) {
              final productId = state.products[i]["productId"].toString();
              final countParse = int.parse(state.cart[productId]["count"]);
              final priceParsing = int.parse(state.cart[productId]["price"]);
              subtotal = subtotal + (priceParsing * countParse);
            }
            if (subtotal >= 20000) {
              shipping.value = 0;
            } else {
              shipping.value = 150;
            }
            totalCost = shipping.value + subtotal;
            return Scaffold(
              appBar: AppBar(
                title: Text("CHECKOUT", style: kTitleText),
                centerTitle: true,
                surfaceTintColor: kTransparent,
                backgroundColor: kGrey200,
                shadowColor: kTransparent,
              ),
              body: const NoAddressAddedTile(),
              bottomSheet: NoAddressBottomsheet(
                kHeight: kHeight,
                subtotal: subtotal,
                shipping: shipping.value,
                totalCost: totalCost,
                kWidth: kWidth,
              ),
            );
          } else {
            List<String> paymentMethods = ["Pay Online", "Cash on Delivery"];
            List<String> addressIds = [];
            state.addresses.forEach((key, value) {
              addressIds.add(key);
            });
            final theAddress = state.addresses;
            theAddress.forEach((key, value) {
              if (addressIds.contains(theAddress[key]["editedKey"])) {
                anSelectedAddress = theAddress[key]["editedKey"];
              } else {
                anSelectedAddress = addressIds.last;
              }
            });
            paymentChoice = paymentMethods[0];
            int subtotal = 0;

            int totalCost = 0;
            for (var i = 0; i < state.products.length; i++) {
              final productId = state.products[i]["productId"].toString();
              final countParse = int.parse(state.cart[productId]["count"]);
              final priceParsing = int.parse(state.cart[productId]["price"]);
              subtotal = subtotal + (priceParsing * countParse);
            }
            if (subtotal >= 20000) {
              shipping.value = 0;
            } else {
              shipping.value = 150;
            }
            totalCost = subtotal + shipping.value;
            return Scaffold(
              appBar: AppBar(
                title: Text("CHECKOUT", style: kTitleText),
                centerTitle: true,
                surfaceTintColor: kTransparent,
                backgroundColor: kGrey200,
                shadowColor: kTransparent,
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: kHeight.height * .46,
                  width: kWidth.width,
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Contact Information', style: kHeadingMedText),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddingAddress(),
                                  ));
                                },
                                child: const Text("Add Address")),
                          ],
                        ),
                      ),
                      EmailPhoneTileEdit(
                        emailNotify: emailNotify,
                        theAddress: theAddress,
                        anKeyForMap: "email",
                        anSubTitleText: "Email",
                        anIcon: const Icon(CupertinoIcons.envelope),
                      ),
                      EmailPhoneTileEdit(
                        emailNotify: numberNotify,
                        theAddress: theAddress,
                        anKeyForMap: "number",
                        anSubTitleText: "Phone",
                        anIcon: const Icon(CupertinoIcons.phone),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address', style: kHeadingMedText),
                            BlocBuilder<DropDownAddressBloc,
                                DropdownAddressState>(
                              builder: (context, state) {
                                return DropDownAddress(
                                    addressed: theAddress,
                                    theAddress: addressIds,
                                    anOnChange: (String? value) {
                                      anSelectedAddress = value.toString();
                                      BlocProvider.of<DropDownAddressBloc>(
                                              context)
                                          .add(AddressChanging(
                                              address: value.toString()));

                                      emailNotify.value =
                                          theAddress["email"].toString();
                                      numberNotify.value =
                                          theAddress["number"].toString();
                                    },
                                    anOption: anSelectedAddress);
                              },
                            ),
                            Text('Payment Method', style: kHeadingMedText),
                            SizedBox(
                              height: kHeight.height * 0.005,
                            ),
                            BlocBuilder<PaymentChoiceDropBloc,
                                PaymentChoiceDropState>(
                              builder: (context, state) {
                                return PaymentDropDown(
                                  theAddress: paymentMethods,
                                  anOnChange: (String? value) {
                                    BlocProvider.of<PaymentChoiceDropBloc>(
                                            context)
                                        .add(OnSelected(
                                            anChoice: value.toString()));
                                  },
                                  anOption: paymentChoice,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomSheet: Container(
                height: kHeight.height * 0.23,
                color: kWhite,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      SizedBox(height: kHeight.height * .01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal", style: kNonboldTitleText),
                          Text('$subtotal', style: kTitleNonBoldText)
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Shipping", style: kNonboldTitleText),
                          Text("₹ ${shipping.value}", style: kTitleNonBoldText)
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Cost", style: kTitleNonBoldText),
                          Text("₹ $totalCost", style: kTitleText)
                        ],
                      ),
                      SizedBox(height: kHeight.height * 0.01),
                      ElevatedButton(
                        style: checkOutButtonStyle(kWidth, kHeight),
                        onPressed: () {
                          if (paymentChoice == "Pay Online") {
                            var options = {
                              'key': 'rzp_test_NXIkMzlJPZFcyU',
                              'amount': totalCost * 100,
                              'name': emailNotify.value,
                              'description': 'Fine T-Shirt',
                              'prefill': {
                                'contact': numberNotify.value,
                                'email': emailNotify.value,
                              }
                            };
                            _razorpay.open(options);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          BlocProvider.of<
                                                      OrderingOnSuccessBloc>(
                                                  context)
                                              .add(AddToOrders(
                                                  anEmail: fireName!.email
                                                      .toString(),
                                                  selectedAddressKey:
                                                      anSelectedAddress,
                                                  shippingCharge: shipping.value
                                                      .toString()));
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          );
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          if (context.mounted) {
                                            snackBar(context,
                                                "Order Placed Successfully ✅");
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(),
                                                ));
                                          }
                                        },
                                        child: Text(
                                          "yes",
                                          style: kSubTextNonBold,
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("no")),
                                  ],
                                  title: const Text("Are you ready to pay..?"),
                                  content: const Text("Are you sure.. "),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                );
                              },
                            );
                          }
                        },
                        child: Text(
                          "Continue to Pay",
                          style: buttontextWhite,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
