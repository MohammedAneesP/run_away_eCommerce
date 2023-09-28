part of 'payment_choice_drop_bloc.dart';

@immutable
sealed class PaymentChoiceDropEvent {}

class OnSelected extends PaymentChoiceDropEvent {
  final String anChoice;
  OnSelected({required this.anChoice});
}