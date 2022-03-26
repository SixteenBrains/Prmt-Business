part of 'signup_cubit.dart';

enum SignUpStatus { initial, submitting, succuss, error }

class SignUpState extends Equatable {
  final String phNo;
  final SignUpStatus status;
  final Failure? failure;
  final String? verificationId;
  final String otp;
  final bool errorOtp;
  final bool otpSent;
  final int? resendToken;

  const SignUpState({
    required this.phNo,
    required this.status,
    this.failure,
    this.verificationId,
    this.otp = '',
    this.otpSent = false,
    this.errorOtp = false,
    this.resendToken,
  });

  factory SignUpState.initial() =>
      const SignUpState(phNo: '', status: SignUpStatus.initial);

  bool get phNoIsEmpty => phNo.length == 10;

  bool get otpIsEmpty => otp.length == 6;

  @override
  List<Object?> get props => [
        phNo,
        status,
        failure,
        otp,
        verificationId,
        errorOtp,
        otpSent,
        resendToken
      ];

  SignUpState copyWith({
    String? phNo,
    SignUpStatus? status,
    Failure? failure,
    String? otp,
    String? verificationId,
    bool? errorOtp,
    bool? otpSent,
    int? resendToken,
  }) {
    return SignUpState(
      phNo: phNo ?? this.phNo,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      errorOtp: errorOtp ?? this.errorOtp,
      otpSent: otpSent ?? this.otpSent,
      resendToken: resendToken ?? this.resendToken,
    );
  }
}
