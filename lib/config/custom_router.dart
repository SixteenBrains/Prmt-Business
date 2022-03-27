import 'package:flutter/material.dart';
import 'package:prmt_admin/screens/dashboard/main_screen.dart';
import '/screens/contact/contact_screen.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case MainScreen.routeName:
        return MainScreen.route();

      case ContactScreen.routeName:
        return ContactScreen.route();
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
