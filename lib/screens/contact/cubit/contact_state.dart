part of 'contact_cubit.dart';

enum ContactStatus { initial, submitting, succuss, error }

class ContactState extends Equatable {
  final String? name;
  final String? email;
  final String? message;
  final ContactStatus status;
  final Failure? failure;

  const ContactState({
    required this.name,
    required this.email,
    required this.message,
    required this.status,
    required this.failure,
  });

  factory ContactState.initial() => const ContactState(
        email: '',
        name: '',
        message: '',
        status: ContactStatus.initial,
        failure: Failure(),
      );

  @override
  bool? get stringify => true;

  bool get fromValid {
    if (name != null && email != null && message != null) {
      return name!.isNotEmpty && email!.isNotEmpty && message!.isNotEmpty;
    }
    return false;
  }

  @override
  List<Object?> get props => [email, name, message, status];

  ContactState copyWith({
    String? name,
    String? email,
    String? message,
    ContactStatus? status,
    Failure? failure,
  }) {
    return ContactState(
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
