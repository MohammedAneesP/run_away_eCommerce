part of 'profile_image_adding_bloc.dart';

class ProfileImageAddingState {
  final bool isLoading;
  final XFile? anImage;
  ProfileImageAddingState({required this.anImage, required this.isLoading});
}

class ProfileImageAddingInitial extends ProfileImageAddingState {
  ProfileImageAddingInitial() : super(anImage: null, isLoading: true);
}
