import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/models/contact_us.dart';
import '/models/failure.dart';
import '/repositories/services/firebase_services.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final FirebaseServices _firebaseServices;
  ContactCubit({required FirebaseServices firebaseServices})
      : _firebaseServices = firebaseServices,
        super(ContactState.initial());

  void nameChanged(String name) async {
    emit(state.copyWith(name: name, status: ContactStatus.initial));
  }

  void emailChanged(String email) async {
    emit(state.copyWith(email: email, status: ContactStatus.initial));
  }

  void messageChanged(String message) async {
    emit(state.copyWith(message: message, status: ContactStatus.initial));
  }

  void submit() async {
    if (state.status == ContactStatus.submitting) return;
    try {
      emit(state.copyWith(status: ContactStatus.submitting));
      await _firebaseServices.sendContactUsInformation(ContactUs(
        name: state.name,
        email: state.email,
        message: state.message,
      ));
      emit(state.copyWith(status: ContactStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(
        status: ContactStatus.error,
        failure: Failure(message: error.toString()),
      ));
    }
  }
}
