import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prmt_admin/blocs/nav/nav_state.dart';
import '/blocs/auth/auth_bloc.dart';
import '/blocs/nav/nav_bloc.dart';
import '/enums/enums.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navBloc = context.read<NavBloc>();
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              'PRMT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            // child: Image.asset('assets/images/logo.png'),
          ),
          for (var item in NavItem.values)
            DrawerListTile(
              press: () => _navBloc.add(UpdateNavItem(item: item)),
              title: MenuLabel(item: item),
              // _label(item, selectedItem: _navBloc.state.item),
              svgSrc: _iconPath(item),
            ),
          DrawerListTile(
            press: () => context.read<AuthBloc>().add(AuthLogoutRequested()),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white54),
            ),
            svgSrc: 'assets/icons/logout.svg',
          )
        ],
      ),
    );
  }
}

String _iconPath(NavItem item) {
  if (item == NavItem.dashboard) {
    return 'assets/icons/menu_dashbord.svg';
  } else if (item == NavItem.payment) {
    return 'assets/icons/menu_tran.svg';
  } else if (item == NavItem.users) {
    return 'assets/icons/users.svg';
  } else if (item == NavItem.ads) {
    return 'assets/icons/ads.svg';
  }

  return '';
}

// Widget _itemIcon(NavItem item) {
//   if (item == NavItem.dashboard) {
//     return const Icon(Icons.dashboard);
//   } else if (item == NavItem.mentorConnect) {
//     return const Icon(Icons.groups, size: 26.0);
//   } else if (item == NavItem.girlTable) {
//     return const Icon(Icons.girl_sharp, size: 26.0);
//   } else if (item == NavItem.profile) {
//     return const Icon(Icons.person, size: 24.0);
//   }

//   return const Icon(Icons.person);
// }

class MenuLabel extends StatelessWidget {
  final NavItem item;
  const MenuLabel({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        if (item == NavItem.dashboard) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DashBoard',
                style: TextStyle(color: Colors.white54),
              ),
              if (item == state.item)
                const Icon(
                  Icons.radio_button_checked,
                  color: Colors.white70,
                  size: 20.0,
                )
            ],
          );
        } else if (item == NavItem.payment) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transactions',
                style: TextStyle(color: Colors.white54),
              ),
              if (item == state.item)
                const Icon(
                  Icons.radio_button_checked,
                  color: Colors.white70,
                  size: 20.0,
                )
            ],
          );
        } else if (item == NavItem.users) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Users',
                style: TextStyle(color: Colors.white54),
              ),
              if (item == state.item)
                const Icon(
                  Icons.radio_button_checked,
                  color: Colors.white70,
                  size: 20.0,
                )
            ],
          );
        } else if (item == NavItem.ads) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ads',
                style: TextStyle(color: Colors.white54),
              ),
              if (item == state.item)
                const Icon(
                  Icons.radio_button_checked,
                  color: Colors.white70,
                  size: 20.0,
                )
            ],
          );
        }

        return const Text('');
      },
    );
  }
}

// String _label(NavItem item, {required NavItem selectedItem}) {
//   if (item == NavItem.dashboard) {
//     return 'DashBoard ${item == selectedItem ? '⚫' : ''}';
//   } else if (item == NavItem.payment) {
//     return 'Transactions ${item == selectedItem ? '⚫' : ''}';
//   } else if (item == NavItem.users) {
//     return 'Users ${item == selectedItem ? '⚫' : ''}';
//   } else if (item == NavItem.ads) {
//     return 'Ads ${item == selectedItem ? '⚫' : ''}';
//   }

//   return '';
// }

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final Widget title;
  final String svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: title,

      // Text(
      //   title,
      //   style: const TextStyle(color: Colors.white54),
      // ),
    );
  }
}
