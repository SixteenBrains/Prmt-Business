part of 'signup_cubit.dart';

enum SignUpStatus { initial, loading, succuss, error }

class SignUpState extends Equatable {
  final String phNo;
  final SignUpStatus status;
  final Failure? failure;

  const SignUpState({required this.phNo, required this.status, this.failure});

  factory SignUpState.initial() =>
      const SignUpState(phNo: '', status: SignUpStatus.initial);

  bool get phNoIsEmpty => phNo.isNotEmpty;

  @override
  List<Object?> get props => [phNo, status, failure];

  SignUpState copyWith({
    String? phNo,
    SignUpStatus? status,
    Failure? failure,
  }) {
    return SignUpState(
      phNo: phNo ?? this.phNo,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
