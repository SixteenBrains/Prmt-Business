import 'package:flutter/material.dart';
import 'package:prmt_business/screens/dashboard/widgets/draft_ads.dart';
import 'package:prmt_business/screens/dashboard/widgets/expired_ads.dart';
import 'package:prmt_business/screens/dashboard/widgets/live_ads.dart';

class MyAds extends StatelessWidget {
  const MyAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          iconTheme: const IconThemeData(
            color: Colors.grey,
            size: 25.0,
          ),
          title: const Text('My Ads'),
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
        body: const TabBarView(
          children: [
            LiveAds(),
            DrafAds(),
            ExpiredAds(),
          ],
        ),
      ),
    );
  }
}
