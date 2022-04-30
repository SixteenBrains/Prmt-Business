import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_admin/models/payment_details.dart';
import '/models/bussiness_user.dart';
import '/models/failure.dart';
import '/repositories/transaction/transaction_repository.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionRepository _transactionRepository;
  TransactionsCubit({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository,
        super(TransactionsState.initial());

  void loadBussinessUsers() async {
    try {
      emit(state.copyWith(status: TransactionsStatus.loading));
      final users = await _transactionRepository.getBussinessTransactions();

      emit(state.copyWith(
          bussinessUsers: users, status: TransactionsStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: TransactionsStatus.error));
    }
  }

  void loadUserPaymentsHistory({required String? userId}) async {
    try {
      emit(state.copyWith(status: TransactionsStatus.loading));
      final transactions = await _transactionRepository.getUserPaymentsHistory(
          bussinessUserId: userId);
      emit(state.copyWith(
          transactions: transactions, status: TransactionsStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: TransactionsStatus.error));
    }
  }

  void changePage() {
    emit(state.copyWith());
  }
}
