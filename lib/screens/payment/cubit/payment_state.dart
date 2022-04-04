part of 'payment_cubit.dart';

enum PaymentStatus { initial, loading, succuss, error }

class PaymentState extends Equatable {
  final PaymentStatus status;
  final Failure failure;

  const PaymentState({
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [status, failure];

  factory PaymentState.initial() =>
      const PaymentState(status: PaymentStatus.initial, failure: Failure());

  PaymentState copyWith({
    PaymentStatus? status,
    Failure? failure,
  }) {
    return PaymentState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() => 'PaymentState(status: $status, failure: $failure)';
}
