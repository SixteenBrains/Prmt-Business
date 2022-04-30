part of 'transactions_cubit.dart';

enum TransactionsStatus { initial, loading, succuss, error }

enum TransactionPage { usersList, transactions }

class TransactionsState extends Equatable {
  final List<BussinessUser?> bussinessUsers;
  final Failure failure;
  final TransactionsStatus status;
  final List<PaymentDetails?> transactions;

  const TransactionsState({
    required this.bussinessUsers,
    required this.failure,
    required this.status,
    this.transactions = const [],
  });

  factory TransactionsState.initial() => const TransactionsState(
        bussinessUsers: [],
        failure: Failure(),
        status: TransactionsStatus.initial,
        transactions: [],
      );

  @override
  List<Object> get props => [bussinessUsers, failure, status];

  TransactionsState copyWith({
    List<BussinessUser?>? bussinessUsers,
    Failure? failure,
    TransactionsStatus? status,
    List<PaymentDetails?>? transactions,
  }) {
    return TransactionsState(
      bussinessUsers: bussinessUsers ?? this.bussinessUsers,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  String toString() =>
      'TransactionsState(bussinessUsers: $bussinessUsers, failure: $failure, status: $status, transactions: $transactions)';
}
