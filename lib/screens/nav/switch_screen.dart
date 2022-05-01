import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/transactions/transactions_screen.dart';
import '/screens/users/users_screen.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/ads/ads_repository.dart';
import '/screens/ads/cubit/ads_cubit.dart';
import '/screens/dashboard/dashboard_screen.dart';
import '/enums/enums.dart';
import '/screens/ads/ads_screen.dart';

class SwitchScreen extends StatelessWidget {
  final NavItem navItem;

  const SwitchScreen({Key? key, required this.navItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (navItem) {
      case NavItem.dashboard:
        return const DashBoardScreen();

      case NavItem.ads:
        return BlocProvider(
          create: (context) => AdsCubit(
              adsRepository: context.read<AdsRepository>(),
              authBloc: context.read<AuthBloc>())
            ..loadAds(),
          child: const AdsScreen(),
        );

      case NavItem.users:
        return const UsersScreen();

      case NavItem.payment:
        return const TransactionsScreen();

      default:
        return const Center(
          child: Text('Wrong'),
        );
    }
  }
}
