import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_image_adding_event.dart';
part 'profile_image_adding_state.dart';

class ProfileImageAddingBloc
    extends Bloc<ProfileImageAddingEvent, ProfileImageAddingState> {
  ProfileImageAddingBloc() : super(ProfileImageAddingInitial()) {
    on<FromGallery>((event, emit) async {
      XFile? galleryImage =
          await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        );
      if (galleryImage == null) {
        return emit(ProfileImageAddingState(anImage: null, isLoading: true));
      } else {
        return emit(
            ProfileImageAddingState(anImage: galleryImage, isLoading: false));
      }
    });
    on<FromCamera>((event, emit) async {
      XFile? cameraImage =
          await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 70);
      if (cameraImage == null) {
        return emit(ProfileImageAddingState(anImage: null, isLoading: true));
      } else {
        return emit(
            ProfileImageAddingState(anImage: cameraImage, isLoading: false));
      }
    });
    on<ClearImage>((event, emit){
      return emit(ProfileImageAddingState(anImage: null, isLoading: true));
    });
  }
}
