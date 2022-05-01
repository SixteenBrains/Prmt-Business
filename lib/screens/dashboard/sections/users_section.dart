import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/config/responsive.dart';
import '/screens/dashboard/cubit/dashboard_cubit.dart';
import '/widgets/loading_indicator.dart';

import 'section_card.dart';

class UsersSection extends StatefulWidget {
  const UsersSection({Key? key}) : super(key: key);

  @override
  State<UsersSection> createState() => _UsersSectionState();
}

class _UsersSectionState extends State<UsersSection> {
  @override
  void initState() {
    context.read<DashboardCubit>().loadUsersCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == DashBoardStatus.loading) {
          return const LoadingIndicator();
        }
        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
          childAspectRatio: 1.25,
          crossAxisSpacing: 14.0,
          children: [
            SectionCard(
                color: const Color(0xffB4E197),
                label: 'Bussiness Users',
                value: state.bussinessUsers ?? 0),
            SectionCard(
              label: 'Promoters',
              value: state.promoters ?? 0,
              color: const Color(0xff83BD75),
            ),
          ],
        );
      },
    );
  }
}
