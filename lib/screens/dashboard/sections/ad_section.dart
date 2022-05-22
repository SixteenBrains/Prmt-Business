import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/config/responsive.dart';
import '/screens/dashboard/cubit/dashboard_cubit.dart';
import '/widgets/loading_indicator.dart';

import 'section_card.dart';

class AdSection extends StatefulWidget {
  const AdSection({Key? key}) : super(key: key);

  @override
  State<AdSection> createState() => _AdSectionState();
}

class _AdSectionState extends State<AdSection> {
  @override
  void initState() {
    context.read<DashboardCubit>().loadAdCount();
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
              label: 'Live Ads',
              value: state.liveAds ?? 0,
              color: const Color(0xff79DAE8),
            ),
            SectionCard(
              label: 'Promoted Ads',
              value: state.promotedAds ?? 0,
              color: const Color(0xff0AA1DD),
            ),
            SectionCard(
              label: 'Expired Ads',
              value: state.expiredAds ?? 0,
              color: const Color(0xffC4DDFF),
            ),
          ],
        );
      },
    );
  }
}
