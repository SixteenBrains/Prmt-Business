import 'package:flutter/material.dart';

import '/enums/enums.dart';
import '/screens/ads/ads_screen.dart';
import '/screens/dashboard/dashbboard.dart';
import '/screens/payments/payments_screen.dart';
import '/screens/users/users_screen.dart';

class SwitchScreen extends StatelessWidget {
  final NavItem navItem;

  const SwitchScreen({Key? key, required this.navItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (navItem) {
      case NavItem.dashboard:
        return const DashBoard();

      case NavItem.ads:
        return const AdsScreen();

      case NavItem.users:
        return const UsersScreen();

      case NavItem.payment:
        return const PaymentsScreen();

      default:
        return const Center(
          child: Text('Wrong'),
        );
    }
  }
}
