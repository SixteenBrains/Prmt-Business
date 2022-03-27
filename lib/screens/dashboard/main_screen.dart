import 'package:flutter/material.dart';
import '/screens/dashboard/dashbboard.dart';
import '/config/responsive.dart';
import '/controllers/menu_controller.dart';
import 'package:provider/provider.dart';
import 'widgets/side_menu.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = '/main';
  const MainScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MainScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashBoard(),
            ),
          ],
        ),
      ),
    );
  }
}
