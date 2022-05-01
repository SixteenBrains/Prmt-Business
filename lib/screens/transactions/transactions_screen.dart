import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/transaction/transaction_repository.dart';
import '/screens/transactions/bussiness_transactions.dart';
import '/screens/transactions/promoters_transactions.dart';

import 'cubit/transactions_cubit.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Bussiness Users',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Promoters',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (context) => TransactionsCubit(
                transactionRepository: context.read<TransactionRepository>(),
              )..loadBussinessUsers(),
              child: const BussinessTransactions(),
            ),
            const PromotersTransactions(),
          ],
        ),
      ),
    );
  }
}
