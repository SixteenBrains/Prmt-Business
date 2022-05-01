import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/nav/nav_state.dart';
import '/config/responsive.dart';

import '/screens/dashboard/widgets/side_menu.dart';
import '/blocs/nav/nav_bloc.dart';
import 'switch_screen.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<NavBloc>(
        create: (context) => NavBloc(),
        child: NavScreen(),
      ),
    );

    // return PageRouteBuilder(
    //   settings: const RouteSettings(name: routeName),
    //   pageBuilder: (context, _, __) => BlocProvider(
    //     create: (context) => NavBloc(),
    //     child: const NavScreen(),
    //   ),
    // );
  }

  NavScreen({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          return Scaffold(
            //key: context.read<MenuCubit>().state.scaffoldKey,
            //  key: scaffoldKey,
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
                  Expanded(
                    // It takes 5/6 part of the screen
                    flex: 5,
                    child: SwitchScreen(
                      navItem: state.item,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
