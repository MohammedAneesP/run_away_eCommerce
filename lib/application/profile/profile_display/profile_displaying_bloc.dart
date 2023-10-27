import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_displaying_event.dart';
part 'profile_displaying_state.dart';

class ProfileDisplayingBloc
    extends Bloc<ProfileDisplayingEvent, ProfileDisplayingState> {
  ProfileDisplayingBloc() : super(ProfileDisplayingInitial()) {
    on<GetProfile>((event, emit) async {
      try {
        final anValue = await FirebaseFirestore.instance
            .collection("users")
            .doc(event.anEmail)
            .get();
        if (anValue.exists) {
          final anProfile = anValue.data();
          if (anProfile!.isEmpty) {
            return emit(ProfileDisplayingState(anProfile: {}, isLoading: true));
          } else {
            return emit(
                ProfileDisplayingState(anProfile: anProfile, isLoading: false));
          }
        } else {
          return emit(ProfileDisplayingState(anProfile: {}, isLoading: true));
        }
      } catch (e) {
        log('${e.toString()},"here');
      }
    });
    on<AddingDetails>((event, emit) async {
      final uniqueName = DateTime.now().toString();
      final fireStorageRef = FirebaseStorage.instance;
      final file = File(event.anImagePath.path);
      final toStorage =
          await fireStorageRef.ref().child("image/$uniqueName").putFile(file);
      final downLoadUrl = await toStorage.ref.getDownloadURL();
      final String anUrl = downLoadUrl;
      final Map<String, dynamic> anMap = {
        "fullname": event.anFullName,
        "nickname": event.anNickName,
        "image": anUrl,
        "emailId": event.anEmail,
      };
      await FirebaseFirestore.instance
          .collection("users")
          .doc(event.anEmail)
          .set(anMap);
      return emit(ProfileDisplayingState(anProfile: anMap, isLoading: false));
    });
  }
}
