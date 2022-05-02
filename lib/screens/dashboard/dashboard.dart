import 'dart:convert';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/ad-details/ad_details_from_id.dart';
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
import 'package:http/http.dart' as http;

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

    // Get any initial links
    //Todo: Work on this
    final PendingDynamicLinkData? initialLink =
        await dynamicLinks.getInitialLink();
    if (initialLink != null) {
      Navigator.of(context).pushNamed(AdDetailsFromId.routeName,
          arguments: AdIdDetailsArgs(adId: '7REUdqeh77VkiDNSUjGa'));
    }

    // Calls when app is in terminated state
    final PendingDynamicLinkData? data = await dynamicLinks.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      //print('')

      // Navigator.pushNamed(context, deepLink.path);
    }

    // listens when app is in background
    dynamicLinks.onLink.listen((dynamicLinkData) {
      print('Dynamic link data $dynamicLinkData');
      print('Dynamic link data ${dynamicLinkData.link}');
      print('Dynamic link data ${dynamicLinkData.utmParameters}');
      print(
          'Dynamic link queryParameters ${dynamicLinkData.link.queryParameters}');
      print('Dynamic link data 2 ${dynamicLinkData.link.data}');
      print('Dynamic link host ${dynamicLinkData.link.host}');
      print('Dynamic link origin ${dynamicLinkData.link.origin}');

      //final host = dynamicLinkData.link.host; //  main link

      print('Dynamic link path ${dynamicLinkData.link.path}');

      print('Dynamic link pathSegments ${dynamicLinkData.link.pathSegments}');

      // final pathSegments = dynamicLinkData.link.pathSegments;
      // final queryData = jsonDecode(pathSegments[0]);
      // print('Query data  - $queryData');

      //  print('Query data runtimetype - ${queryData.runtimeType}');

      print(
          'Dynamic link queryParametersAll ${dynamicLinkData.link.queryParametersAll}');

      //final adData =

      final adDataQueryParams = dynamicLinkData.link.queryParameters;

      final adDataParams = adDataQueryParams['ad'];
      print('Ad ata params $adDataParams');
      if (adDataParams != null) {
        final adData = jsonDecode(adDataParams);
        print('Ad data $adData');
        print('Ad data ${adData.runtimeType}');

        Navigator.of(context).pushNamed(AdDetailsFromId.routeName,
            arguments: AdIdDetailsArgs(adId: '7REUdqeh77VkiDNSUjGa'));
      }

      // final String link = dynamicLinkData.link.toString();

      // launchAdUrl(link);

      // await launch(link);

      // var adLink = Uri.parse(dynamicLinkData.link.toString());

      // Navigator.of(context).pushNamed(AdWebView.routeName,
      //     arguments: AdWebViewArgs(adUrl: dynamicLinkData.link.toString()));

      /// Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).

        // .onData((data) {
        //   print('On data runs  ${data.link}');
        //   final String link = data.link.toString();

        //   print('Dynamic link data ${data.utmParameters}');

        //   launchAdUrl(link);
        // });

        onError((error) {
      print('onLink error');
      print(' Error in getting dynamic link ${error.message}');
    });
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

  void transfer() async {
    try {
      //   https://razorpay.com/docs/api/payments/route/#create-transfers-from-payments
      // final _dio = Dio();
      final body = jsonEncode({
        'transfers': [
          {
            // "key_id": "rzp_test_zWedU2ftf6Ssa2",
            // "key_secret": "NykqFmthLvzWZbgizS6F4mqO",
            'account':
                'acc_JP6GI4wiCjvowh', //Please replace with appropriate ID.
            'amount': 50,
            'currency': 'INR',
            'notes': {'name': 'Rishu Kumar', 'roll_no': 'IEC2011025'},
            'linked_account_notes': ['roll_no'],
            'on_hold': true,
            'on_hold_until': 1671222870
          },
        ]
      });
      Map<String, String> headers = {
        'Authorization':
            'Basic cnpwX3Rlc3RfeldlZFUyZnRmNlNzYTI6TnlrcUZtdGhMdnpXWmJnaXpTNkY0bXFP'
        // 'Authorization': 'Bearer rzp_test_zWedU2ftf6Ssa2',
        // 'Content-Type': 'application/json',
        // 'key_id': 'rzp_test_zWedU2ftf6Ssa2',
        // //'Content-Type': 'application/x-www-form-urlencoded',
        // 'key_secret': 'NykqFmthLvzWZbgizS6F4mqO',
      };

      final result = await http.post(
        Uri.parse(
            'https://api.razorpay.com/v1/payments/pay_JP6N90DGlooJZM/transfers'),
        body: body,
        headers: headers,
      );
      print('Result ---- ${result.body}');
    } catch (error) {
      print('Error in transfer ${error.toString()}');
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
              // floatingActionButton: FloatingActionButton(onPressed: () async {
              //   transfer();
              // }),

              //   print('Tapped');
              //   final data = jsonEncode({'name': 'Rishu', 'id': '123'});
              //   final dynamicLinkParams = DynamicLinkParameters(
              //     // link: Uri.parse('https://flutter.dev/$data'),
              //     link: Uri.parse('https://flutter.dev/?ad=$data'),
              //     uriPrefix: 'https://prmtbusiness.page.link',
              //     androidParameters: const AndroidParameters(
              //         packageName: 'com.sixteenbrains.prmt_business'),
              //     iosParameters:
              //         const IOSParameters(bundleId: 'com.example.app.ios'),
              //   );
              //   final dynamicLink = await FirebaseDynamicLinks.instance
              //       .buildLink(dynamicLinkParams);

              //   print('Dynamic links --$dynamicLink');
              // },
              //),
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
