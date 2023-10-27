part of 'profile_displaying_bloc.dart';

@immutable
sealed class ProfileDisplayingEvent {}

class GetProfile extends ProfileDisplayingEvent {
  final String anEmail;
  GetProfile({required this.anEmail});
}
class AddingDetails extends ProfileDisplayingEvent {
  final String anEmail;
  final String anNickName;
  final String anFullName;
  final XFile anImagePath;
  AddingDetails({
    required this.anEmail,
    required this.anFullName,
    required this.anNickName,
    required this.anImagePath,
  });
}

