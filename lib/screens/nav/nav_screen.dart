import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_admin/config/responsive.dart';

import '/screens/dashboard/widgets/side_menu.dart';
import '/blocs/nav/nav_bloc.dart';
import '/enums/enums.dart';

import 'switch_screen.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<NavBloc>(
        create: (context) => NavBloc(),
        child: const NavScreen(),
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

  const NavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<NavBloc, NavItem>(
        builder: (context, activeNavItem) {
          return Scaffold(
            drawer: const SideMenu(),
            // floatingActionButton: FloatingActionButton(onPressed: () async {
            //   await context.read<MentorRepository>().getMentors(user: null);
            // }),
            //backgroundColor: Colors.black45,
            //  backgroundColor: Color.fromRGBO(25, 23, 37, 1),
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
                      child: SwitchScreen(navItem: activeNavItem)

                      //  DashBoard(),
                      ),
                ],
              ),
            ),

            //SwitchScreen(navItem: activeNavItem),
            // bottomNavigationBar: BottomNavBar(
            //   navItem: activeNavItem,
            //   onitemSelected: (item) => BlocProvider.of<NavBloc>(context)
            //       .add(UpdateNavItem(item: item)),
            // ),
          );
        },
      ),
    );
  }
}
