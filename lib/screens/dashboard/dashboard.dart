import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/widgets/display_image.dart';
import '/repositories/ad/ad_repository.dart';
import '/screens/dashboard/bloc/dashboard_bloc.dart';
import 'cubit/ads_cubit.dart';
import '/blocs/auth/auth_bloc.dart';
import '/screens/create-ad/screens/create_ad_sceen.dart';
import '/screens/profile/profile_screen.dart';
import '/widgets/bottom_nav_button.dart';
import 'widgets/draft_ads.dart';
import 'widgets/expired_ads.dart';
import 'widgets/live_ads_tab.dart';

class DashBoard extends StatefulWidget {
  static const String routeName = '/dashboard';
  const DashBoard({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AdsCubit(
              adRepository: context.read<AdRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
          BlocProvider(
            create: (context) => DashboardBloc(
              adsCubit: context.read<AdsCubit>(),
            ),
          ),
        ],
        child: const DashBoard(),
      ),
    );
  }

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = const [
    Tab(text: 'Live Ads'),
    Tab(text: 'Draft Ads'),
    Tab(text: 'Expired'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    print('Canvas height -- ${_canvas.height}');
    final _authBloc = context.read<AuthBloc>();

    print('Current user -- ${_authBloc.state.user}');
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<DashboardBloc, DashBoardState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 200.0,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/bg_blue.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 200.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed(ProfileScreen.routeName),
                                      child: CircleAvatar(
                                        radius: 22.0,
                                        child: ClipOval(
                                          child: DisplayImage(
                                            imageUrl: context
                                                .read<AuthBloc>()
                                                .state
                                                .user
                                                ?.profileImg,
                                            height: double.infinity,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20.0),
                                    RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'PRMT',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(text: ' - Business'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Stack(
                                    children: const [
                                      Center(
                                        child: Icon(
                                          Icons.notifications_outlined,
                                          size: 25.0,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8.0,
                                        right: 10.0,
                                        child: CircleAvatar(
                                          radius: 4.0,
                                          backgroundColor: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Total spent on ads',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  'Number of ads',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                const Text(
                                  '₹ 5,000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: _canvas.width * 0.35),
                                const Text(
                                  '4',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      backgroundColor: const Color(0xffF5F5F5),
                      appBar: PreferredSize(
                        child: AppBar(
                          elevation: 0.0,
                          backgroundColor: Colors.white,
                          bottom: TabBar(
                            controller: _tabController,
                            labelStyle: const TextStyle(fontSize: 16.0),
                            onTap: (index) {
                              if (index == 0) {
                                context.read<AdsCubit>().loadLiveAds();
                              } else if (index == 1) {
                                context.read<AdsCubit>().loadDraftAds();
                              } else {
                                context.read<AdsCubit>().loadExpiredAds();
                              }
                            },
                            unselectedLabelColor: Colors.grey,
                            labelColor: Colors.blue,
                            indicatorColor: Colors.blue,
                            labelPadding: const EdgeInsets.only(bottom: 5.0),
                            tabs: myTabs,
                          ),
                        ),
                        preferredSize: const Size.fromHeight(60.0),
                      ),
                      body: Stack(
                        children: [
                          TabBarView(
                            controller: _tabController,
                            children: const [
                              LiveAdsTab(),
                              DrafAds(),
                              ExpiredAds(),
                            ],
                          ),
                          Positioned(
                            left: 20.0,
                            right: 20.0,
                            bottom: 20.0,
                            child: BottomNavButton(
                                label: 'CREATE NEW AD',
                                isEnabled: true,
                                onTap: () => Navigator.of(context)
                                    .pushNamed(CreateAdScreen.routeName)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
