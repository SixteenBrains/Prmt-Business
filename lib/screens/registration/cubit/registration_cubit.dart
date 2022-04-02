import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/appuser.dart';
import '/models/business_type.dart';
import '/repositories/registraion/registration_repository.dart';
import '/models/failure.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationRepository _registrationRepository;
  final AuthBloc _authBloc;

  RegistrationCubit({
    required RegistrationRepository registrationRepository,
    required AuthBloc authBloc,
  })  : _registrationRepository = registrationRepository,
        _authBloc = authBloc,
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

  void changePage(RegistrationCurrentPage page) {
    emit(state.copyWith(currentPage: page, status: RegistrationStatus.initial));
  }

  void getCurrentUser() async {
    try {
      emit(state.copyWith(status: RegistrationStatus.submitting));
      final user = await _registrationRepository.getCurrentUser(
          uid: _authBloc.state.user?.uid);
      if (user != null) {
        emit(state.copyWith(
            currentUser: user, status: RegistrationStatus.succuss));
      } else {
        emit(state.copyWith(status: RegistrationStatus.initial));
      }
    } on Failure catch (error) {
      emit(state.copyWith(status: RegistrationStatus.error, failure: error));
    }
  }

  void getBusinessTypes() async {
    try {
      emit(state.copyWith(status: RegistrationStatus.loading));
      final types = await _registrationRepository.getBusinessType();
      emit(state.copyWith(status: RegistrationStatus.initial, types: types));
    } on Failure catch (error) {
      print('Error in getting business types ${error.toString()}');
      emit(state.copyWith(status: RegistrationStatus.error, failure: error));
    }
  }

  void chooseBusinessType(BusinessType type) async {
    emit(state.copyWith(businessType: type));
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
          uid: _authBloc.state.user?.uid,
          businessType: state.businessType?.type,
        ),
      );

      emit(state.copyWith(status: RegistrationStatus.succuss));
    } on Failure catch (error) {
      emit(state.copyWith(status: RegistrationStatus.error, failure: error));
    }
  }
}
