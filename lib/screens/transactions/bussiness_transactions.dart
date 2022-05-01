import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_admin/screens/transactions/user_transactions.dart';
import '/screens/transactions/cubit/transactions_cubit.dart';
import '/widgets/loading_indicator.dart';
import '/constants/constants.dart';
import '/screens/dashboard/widgets/header.dart';

class BussinessTransactions extends StatelessWidget {
  const BussinessTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: BlocConsumer<TransactionsCubit, TransactionsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status == TransactionsStatus.loading) {
                  return const LoadingIndicator();
                }
                return ListView.builder(
                  itemCount: state.bussinessUsers.length,
                  itemBuilder: (context, index) {
                    final user = state.bussinessUsers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          if (user?.uid != null) {
                            Navigator.of(context).pushNamed(
                                UserTransactions.routeName,
                                arguments:
                                    UserTransactionsArgs(userId: user!.uid!));
                          }
                        },
                        child: Card(
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ListTile(
                                title: Text(
                                  user?.name ?? 'N/A',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                subtitle: Text(
                                  user?.email ?? 'N/A',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                ),
                                child: Text(
                                  user?.businessType ?? 'N/A',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),

      ///  ),
    );
  }
}
