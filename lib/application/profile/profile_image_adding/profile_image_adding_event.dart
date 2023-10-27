part of 'profile_image_adding_bloc.dart';

@immutable
sealed class ProfileImageAddingEvent {}

class FromGallery extends ProfileImageAddingEvent {}

class FromCamera extends ProfileImageAddingEvent {}

class ClearImage extends ProfileImageAddingEvent{}
