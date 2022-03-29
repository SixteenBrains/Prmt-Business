part of 'registration_cubit.dart';

enum RegistrationStatus { initial, loading, submitting, succuss, error }

enum CurrentPage { fName, email, businessName, businessType }

class RegistrationState extends Equatable {
  final String fName;
  final String email;
  final String businessName;
  final RegistrationStatus status;
  final Failure failure;
  final CurrentPage currentPage;
  final List<BusinessType?> types;
  final AppUser? currentUser;
  final BusinessType? businessType;

  const RegistrationState({
    required this.fName,
    required this.email,
    required this.businessName,
    required this.status,
    required this.failure,
    required this.currentPage,
    this.types = const [],
    this.currentUser,
    this.businessType,
  });

  factory RegistrationState.initial() => const RegistrationState(
        fName: '',
        email: '',
        businessName: '',
        status: RegistrationStatus.initial,
        failure: Failure(),
        currentPage: CurrentPage.fName,
        types: [],
        currentUser: null,
        businessType: null,
      );

  @override
  List<Object?> get props {
    return [
      fName,
      email,
      businessName,
      status,
      failure,
      currentPage,
      types,
      currentUser,
      businessType,
    ];
  }

  RegistrationState copyWith({
    String? fName,
    String? email,
    String? businessName,
    RegistrationStatus? status,
    Failure? failure,
    CurrentPage? currentPage,
    List<BusinessType?>? types,
    AppUser? currentUser,
    BusinessType? businessType,
  }) {
    return RegistrationState(
      fName: fName ?? this.fName,
      email: email ?? this.email,
      businessName: businessName ?? this.businessName,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      currentPage: currentPage ?? this.currentPage,
      types: types ?? this.types,
      currentUser: currentUser ?? this.currentUser,
      businessType: businessType ?? this.businessType,
    );
  }

  @override
  String toString() {
    return 'RegistrationState(fName: $fName, email: $email, businessName: $businessName, status: $status, failure: $failure, currentPage: $currentPage, types: $types, currentUser: $currentUser, businessType: $businessType)';
  }
}
