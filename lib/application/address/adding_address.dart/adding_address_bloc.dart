import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'adding_address_event.dart';
part 'adding_address_state.dart';

class AddingAddressBloc extends Bloc<AddingAddressEvent, AddingAddressState> {
  AddingAddressBloc() : super(AddingAddressInitial()) {
    on<AddingAnAddress>((event, emit) async {
      try {
        final anData = await FirebaseFirestore.instance
            .collection("address")
            .doc(event.anEmail)
            .get();
        if (anData.exists) {
          final anValue = anData.data();
          if (anValue!.isEmpty) {
            final theKey = DateTime.now().toString();
            Map<String, dynamic> anAddress = {
              theKey: {
                "name": event.name,
                "email": event.userEmail,
                "place": event.place,
                "address": event.address,
                "landmark": event.landmark,
                "number": event.number,
                "pincode": event.pincode,
                "keyValue": theKey,
                "editedKey": event.editAddressKey,
              }
            };
            await FirebaseFirestore.instance
                .collection("address")
                .doc(event.anEmail)
                .set(anAddress);
            return emit(AddingAddressState(
                errorMessage: "successfully Added", anAddress: anAddress));
          } else {
            final theKey = DateTime.now().toString();
            Map<String, dynamic> anAddress = {
              theKey: {
                "name": event.name,
                "email": event.userEmail,
                "place": event.place,
                "address": event.address,
                "landmark": event.landmark,
                "number": event.number,
                "pincode": event.pincode,
                "keyValue": theKey,
              }
            };
            anValue.addAll(anAddress);
              anValue.forEach((key, value) {
            anValue[key]["editedKey"] = event.editAddressKey;
          });
            await FirebaseFirestore.instance
                .collection("address")
                .doc(event.anEmail)
                .set(anValue);
            return emit(AddingAddressState(
                errorMessage: "successfully Added", anAddress: anAddress));
          }
        } else {
          final theKey = DateTime.now().toString();
          Map<String, dynamic> anAddress = {
            theKey: {
              "name": event.name,
              "email": event.userEmail,
              "place": event.place,
              "address": event.address,
              "landmark": event.landmark,
              "number": event.number,
              "pincode": event.pincode,
              "keyValue": theKey,
              "editedKey": event.editAddressKey,
            }
          };
          await FirebaseFirestore.instance
              .collection("address")
              .doc(event.anEmail)
              .set(anAddress);
          return emit(AddingAddressState(
              errorMessage: "successfully Added", anAddress: anAddress));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
