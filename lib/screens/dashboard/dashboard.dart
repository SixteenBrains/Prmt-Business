import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '/widgets/loading_indicator.dart';
import '/repositories/payment/payment_repository.dart';
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
              paymentRepository: context.read<PaymentRepository>(),
              authBloc: context.read<AuthBloc>(),
            )..add(LoadDashBoard()),
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
    initDynamicLinks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    dynamicLinks.onLink.listen((dynamicLinkData) {
      print('Dynamic link data $dynamicLinkData');
      print('Dynamic link data ${dynamicLinkData.link}');

      // final String link = dynamicLinkData.link.toString();

      // launchAdUrl(link);

      // await launch(link);

      // var adLink = Uri.parse(dynamicLinkData.link.toString());

      // Navigator.of(context).pushNamed(AdWebView.routeName,
      //     arguments: AdWebViewArgs(adUrl: dynamicLinkData.link.toString()));

      /// Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onData((data) {
      print('On data runs  ${data.link}');
      final String link = data.link.toString();

      launchAdUrl(link);
    });

    // onError((error) {
    //   print('onLink error');
    //   print(' Error in getting dynamic link ${error.message}');
    // });
  }

  void dylink() async {
    FirebaseDynamicLinks.instance.onLink.listen((event) {}).onDone(() {});
  }

  void launchAdUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        launch(url);
      }
    } catch (error) {
      print('Error in launching url  ${error.toString()}');
    }
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
          if (state.status == DashBoardStatus.loading) {
            return const Scaffold(body: LoadingIndicator());
          }
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  print('Tapped');
                  final dynamicLinkParams = DynamicLinkParameters(
                    link: Uri.parse(
                      'https://www.flipkart.com/whirlpool-4-1-convertible-cooling-1-5-ton-3-star-split-inverter-ac-white/p/itm41cb594a1f24e?pid=ACNGAJ34NRZUNCPZ&lid=LSTACNGAJ34NRZUNCPZSPMDCI&marketplace=FLIPKART&store=j9e%2Fabm%2Fc54&srno=b_1_1&otracker=hp_bannerads_1_3.bannerAdCard.BANNERADS_AC_4WH7HKVIP23G&fm=organic&iid=9d2e4b93-9541-4655-b242-6b3d109dbd7e.ACNGAJ34NRZUNCPZ.SEARCH&ppt=hp&ppn=homepage&ssid=v4nm3hvhdc0000001650397944088',
                    ),
                    // 'https://www.amazon.in/dp/B01L8ZNWN2?ref_=cm_sw_r_cp_ud_dp_SKH9RQXA61VXM6FC156P'),
                    uriPrefix: 'https://prmtbusiness.page.link',
                    androidParameters: const AndroidParameters(
                        packageName: 'com.sixteenbrains.prmt_business'),
                    iosParameters:
                        const IOSParameters(bundleId: 'com.example.app.ios'),
                  );
                  final dynamicLink = await FirebaseDynamicLinks.instance
                      .buildLink(dynamicLinkParams);

                  print('Dynamic links --$dynamicLink');
                },
              ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(
                                                  ProfileScreen.routeName),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹ ${state.totalSpents ?? 'N/A'}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: _canvas.width * 0.35),
                                      Text(
                                        '${state.noOfAds ?? 'N/A'}',
                                        //'4',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                labelPadding:
                                    const EdgeInsets.only(bottom: 5.0),
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
