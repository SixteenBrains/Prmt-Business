import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/models/failure.dart';
part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final _auth = FirebaseAuth.instance;
  SignUpCubit() : super(SignUpState.initial());

  @override
  Future<void> close() {
    return super.close();
  }

  void phoneNoChanged(String phNo) {
    emit(state.copyWith(phNo: phNo, status: SignUpStatus.initial));
  }

  void otpChanged(String otp) {
    emit(state.copyWith(otp: otp, errorOtp: false));
  }

  void verificationIdChanged() {
    emit(
      state.copyWith(
        verificationId: null,
        otpSent: false,
        status: SignUpStatus.initial,
      ),
    );
  }

  void verifyPhoneNumber({String? phNo, int? resendToken}) async {
    try {
      emit(state.copyWith(status: SignUpStatus.submitting));
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91 ${phNo ?? state.phNo}',
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
        verificationCompleted: (credential) {
          print('Verification completed $credential');
          emit(state.copyWith(status: SignUpStatus.succuss));
        },
        codeSent: (String verificationId, int? resendToken) async {
          emit(
            state.copyWith(
              verificationId: verificationId,
              status: SignUpStatus.initial,
              otpSent: true,
              resendToken: resendToken,
            ),
          );
        },
        forceResendingToken: resendToken ?? state.resendToken,
        verificationFailed: (error) {
          print('Error in auth ${error.message}');
          emit(state.copyWith(
              failure: Failure(
                  message:
                      error.message ?? 'Error in phone number verification'),
              status: SignUpStatus.error));
        },
      );
    } catch (error) {
      print('Error in phone veifation ${error.toString()}');
      emit(state.copyWith(
          failure: const Failure(message: 'Error in phone verification'),
          status: SignUpStatus.error));
    }
  }

  void verifyOtp({required String verificationId}) async {
    try {
      if (state.otpIsEmpty) {
        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: state.otp,
        );

        print('Otp send --- ${credential.smsCode}');
        print('Otp entered by user ${state.otp}');
        await _auth.signInWithCredential(credential);

        // if (credential.smsCode != state.otp) {
        //   emit(state.copyWith(errorOtp: true));
        // } else {
        //   // Sign the user in (or link) with the credential

        // }
      }
    } catch (error) {
      print('Error in verify otp ${error.toString()}');
      emit(state.copyWith(
          failure: const Failure(message: 'Invalid Otp'),
          errorOtp: true,
          status: SignUpStatus.error));
    }
  }
}
