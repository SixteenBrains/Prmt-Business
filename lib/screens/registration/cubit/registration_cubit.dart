import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_business/models/appuser.dart';
import 'package:prmt_business/repositories/registraion/registration_repository.dart';
import '/models/failure.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationRepository _registrationRepository;

  RegistrationCubit({required RegistrationRepository registrationRepository})
      : _registrationRepository = registrationRepository,
        super(RegistrationState.initial());

  void fNameChanged(String value) {
    emit(state.copyWith(fName: value, status: RegistrationStatus.initial));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: RegistrationStatus.initial));
  }

  void businessNameChanged(String value) {
    emit(state.copyWith(
        businessName: value, status: RegistrationStatus.initial));
  }

  void changePage(CurrentPage page) {
    emit(state.copyWith(currentPage: page, status: RegistrationStatus.initial));
  }

  void registerUser() async {
    try {
      emit(state.copyWith(status: RegistrationStatus.submitting));
      await _registrationRepository.registerUser(
        user: AppUser(
          name: state.fName,
          businessName: state.businessName,
          email: state.email,
          createdAt: DateTime.now(),
        ),
      );

      emit(state.copyWith(status: RegistrationStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(status: RegistrationStatus.error, failure: error));
    }
  }
}
