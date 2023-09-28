
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:run_away/presentation/Screens/address.dart/address.dart';

part 'payment_choice_drop_event.dart';
part 'payment_choice_drop_state.dart';

class PaymentChoiceDropBloc extends Bloc<PaymentChoiceDropEvent, PaymentChoiceDropState> {
  PaymentChoiceDropBloc() : super(PaymentChoiceDropInitial()) {
    on<OnSelected>((event, emit) {
     paymentChoice = event.anChoice;
     return emit(PaymentChoiceDropState(anChoice: paymentChoice)); 
    });
  }
}
