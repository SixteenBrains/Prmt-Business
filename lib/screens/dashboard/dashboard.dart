import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/auth/auth_bloc.dart';
import '/screens/create-ad/screens/create_ad_sceen.dart';
import '/screens/profile/profile_screen.dart';
import '/widgets/bottom_nav_button.dart';
import 'widgets/draft_ads.dart';
import 'widgets/expired_ads.dart';
import 'widgets/live_ads.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashBoard({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const DashBoard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    print('Canvas height -- ${_canvas.height}');
    final _authBloc = context.read<AuthBloc>();

    print('Current user -- ${_authBloc.state.user}');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const ProfileScreen(),
                                      ),
                                    ),
                                    child: const CircleAvatar(
                                      radius: 22.0,
                                      backgroundImage: NetworkImage(
                                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
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
                        bottom: const TabBar(
                          unselectedLabelColor: Colors.grey,
                          labelColor: Colors.blue,
                          indicatorColor: Colors.blue,
                          labelPadding: EdgeInsets.only(bottom: 14.0),
                          tabs: [
                            Text(
                              'Live Ads',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              'Draft Ads',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              'Expired',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      preferredSize: const Size.fromHeight(60.0),
                    ),
                    body: Stack(
                      children: [
                        const TabBarView(
                          children: [
                            LiveAds(),
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
        ),
      ),
    );
  }
}
