part of 'registration_cubit.dart';

enum RegistrationStatus { initial, submitting, succuss, error }

enum CurrentPage { fName, email, businessName }

class RegistrationState extends Equatable {
  final String fName;
  final String email;
  final String businessName;
  final RegistrationStatus status;
  final Failure failure;
  final CurrentPage currentPage;

  const RegistrationState({
    required this.fName,
    required this.email,
    required this.businessName,
    required this.status,
    required this.failure,
    required this.currentPage,
  });

  factory RegistrationState.initial() => const RegistrationState(
        fName: '',
        email: '',
        businessName: '',
        status: RegistrationStatus.initial,
        failure: Failure(),
        currentPage: CurrentPage.fName,
      );

  @override
  List<Object> get props {
    return [
      fName,
      email,
      businessName,
      status,
      failure,
      currentPage,
    ];
  }

  RegistrationState copyWith({
    String? fName,
    String? email,
    String? businessName,
    RegistrationStatus? status,
    Failure? failure,
    CurrentPage? currentPage,
  }) {
    return RegistrationState(
      fName: fName ?? this.fName,
      email: email ?? this.email,
      businessName: businessName ?? this.businessName,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  String toString() {
    return 'RegistrationState(fName: $fName, email: $email, businessName: $businessName, status: $status, failure: $failure, currentPage: $currentPage)';
  }
}
