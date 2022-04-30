import 'package:flutter/material.dart';
import '/screens/ads/screens/ad_details.dart';
import '/screens/transactions/user_transactions.dart';
import '/repositories/auth/auth_wrapper.dart';
import '/screens/dashboard/main_screen.dart';
import '/screens/login/login_screen.dart';
import '/screens/nav/nav_screen.dart';
import '/screens/contact/contact_screen.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case MainScreen.routeName:
        return MainScreen.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case NavScreen.routeName:
        return NavScreen.route();

      case ContactScreen.routeName:
        return ContactScreen.route();

      case AdDetails.routeName:
        return AdDetails.route(args: settings.arguments as AdsDetailsArgs);

      case UserTransactions.routeName:
        return UserTransactions.route(
            args: settings.arguments as UserTransactionsArgs);

      default:
        return ErrorRoute.route();
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({Key? key}) : super(key: key);

  static const String routeNmae = '/error';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeNmae),
      builder: (_) => const ErrorRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil(AuthWrapper.routeName, (route) => false);
    return Center(
      child: Column(
        children: [
          const Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6.0),
          TextButton(
              onPressed: () {
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     AuthWrapper.routeName, (route) => false);
              },
              child: const Text('Re Try'))
        ],
      ),
    );
  }
}
