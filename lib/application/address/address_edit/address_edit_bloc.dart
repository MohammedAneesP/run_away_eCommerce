import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'address_edit_event.dart';
part 'address_edit_state.dart';

class AddressEditBloc extends Bloc<AddressEditEvent, AddressEditState> {
  AddressEditBloc() : super(AddressEditInitial()) {
    on<EditingAddress>((event, emit) async {
      try {
        final anValue = await FirebaseFirestore.instance
            .collection("address")
            .doc(event.anEmail)
            .get();
        if (anValue.exists) {
          final allAddress = anValue.data();
          if (allAddress!.isEmpty) {
            return emit(AddressEditState(
                anErrorMessage: "Something went wrong", theAddresses: {}));
          } else {
            Map<String, dynamic> anAddress = {};
            anAddress = allAddress[event.anMapKey];
            if (anAddress.isEmpty) {
              return emit(AddressEditState(
                  anErrorMessage: "Something went wrong", theAddresses: {}));
            } else {
              return emit(AddressEditState(
                  anErrorMessage: "", theAddresses: anAddress));
            }
          }
        } else {
          return emit(AddressEditState(
              anErrorMessage: "Something went wrong", theAddresses: {}));
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<UpdatingAddress>((event, emit) async {
      final anData = await FirebaseFirestore.instance
          .collection("address")
          .doc(event.anEmail)
          .get();
      if (anData.exists) {
        final allAddress = anData.data();
        if (allAddress!.isEmpty) {
          return emit(AddressEditState(
              anErrorMessage: "Error Occured", theAddresses: {}));
        } else {
          Map<String, dynamic> editAddress = {
            "name": event.name,
            "email": event.userEmail,
            "place": event.place,
            "address": event.address,
            "landmark": event.landmark,
            "number": event.number,
            "pincode": event.pincode,
            "keyValue": event.anMapkey,
          };

          allAddress[event.anMapkey] = editAddress;
          allAddress.forEach((key, value) {
            allAddress[key]["editedKey"] = event.editAddressKey;
          });
  
          await FirebaseFirestore.instance
              .collection("address")
              .doc(event.anEmail)
              .set(allAddress);
          return emit(
              AddressEditState(anErrorMessage: "", theAddresses: editAddress));
        }
      } else {
        return emit(AddressEditState(
            anErrorMessage: "Error Occured", theAddresses: {}));
      }
    });
  }
}
