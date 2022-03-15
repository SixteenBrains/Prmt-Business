import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_business/models/failure.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState.initial());

  void phoneNoChanged(String phNo) {
    emit(state.copyWith(phNo: phNo, status: SignUpStatus.initial));
  }
}
