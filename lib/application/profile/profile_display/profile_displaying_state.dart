part of 'profile_displaying_bloc.dart';

class ProfileDisplayingState {
  final Map<String, dynamic> anProfile;
  final bool isLoading;
  ProfileDisplayingState({required this.anProfile,required this.isLoading});
}

class ProfileDisplayingInitial extends ProfileDisplayingState {
  ProfileDisplayingInitial() : super(anProfile: {},isLoading: true);
}
