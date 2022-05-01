import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '/repositories/transaction/transaction_repository.dart';
import '/screens/transactions/cubit/transactions_cubit.dart';
import '/widgets/loading_indicator.dart';

class UserTransactionsArgs {
  final String userId;

  UserTransactionsArgs({required this.userId});
}

class UserTransactions extends StatelessWidget {
  static const String routeName = '/userTransactions';
  const UserTransactions({Key? key}) : super(key: key);

  static Route route({required UserTransactionsArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => TransactionsCubit(
          transactionRepository: context.read<TransactionRepository>(),
        )..loadUserPaymentsHistory(userId: args.userId),
        child: const UserTransactions(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          Expanded(
            child: BlocConsumer<TransactionsCubit, TransactionsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status == TransactionsStatus.loading) {
                  return const LoadingIndicator();
                }
                if (state.transactions.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Transactions Done',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];
                    String? time;
                    if (transaction?.createdAt != null) {
                      //time = DateFormat.MMMMd().format(transaction!.createdAt!);
                      time =
                          DateFormat.yMMMMd().format(transaction!.createdAt!);
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.outbound,
                            size: 42.0,
                          ),
                          title: Text(
                            'For (${transaction?.productTitle ?? 'N/A'})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Chip(
                            backgroundColor: Colors.blue,
                            label: Text(
                              '₹ ${transaction?.amount ?? ''}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            time ?? 'N/A',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
