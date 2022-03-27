import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              title: _label(item),
              svgSrc: _iconPath(item),
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
    return 'assets/icons/menu_setting.svg';
  } else if (item == NavItem.ads) {
    return 'assets/icons/menu_setting.svg';
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

String _label(NavItem item) {
  if (item == NavItem.dashboard) {
    return 'DashBoard';
  } else if (item == NavItem.payment) {
    return 'Transactions';
  } else if (item == NavItem.users) {
    return 'Users';
  } else if (item == NavItem.ads) {
    return 'Ads';
  }

  return '';
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
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
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
