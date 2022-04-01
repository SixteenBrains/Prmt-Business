import 'package:flutter/material.dart';
import '/models/ad_model.dart';
import '/models/chart_data.dart';

const List<AdModel> liveAds = [
  AdModel(
    adName: 'Himalaya Ashvagandha',
    imageUrl: 'https://m.media-amazon.com/images/I/81HHLzHnF0L._SL1500_.jpg',
    budget: 1500,
    availableBalance: 1170,
    timeRemaining: '3 Days Remaining',
    clicksMetrics: [
      ChartData(
        count: 40,
        color: Color(0xff19CED7),
      ),
      ChartData(
        count: 50,
        color: Color(0xffC6F3F5),
      ),
    ],
    convertsMetrics: [
      ChartData(
        count: 30,
        color: Color(0xff7CDA94),
      ),
      ChartData(
        count: 80,
        color: Color(0xffD7F4DF),
      ),
    ],
    spentsMetrics: [
      ChartData(
        count: 20,
        color: Color(0xffFEDD87),
      ),
      ChartData(
        count: 60,
        color: Color(0xFEDD874D),
      ),
    ],
  ),
  AdModel(
    isNegative: true,
    adName: 'Nivea Mens',
    imageUrl:
        'https://images-us.nivea.com/-/media/local/in/boday_page/3_banner_3080x806.png?rx=1304&ry=0&rw=1452&rh=805',
    budget: 900,
    availableBalance: 100,
    timeRemaining: '12 hours remaining',
    clicksMetrics: [
      ChartData(
        count: 40,
        color: Color(0xff19CED7),
      ),
      ChartData(
        count: 50,
        color: Color(0xffC6F3F5),
      ),
    ],
    convertsMetrics: [
      ChartData(
        count: 30,
        color: Color(0xff7CDA94),
      ),
      ChartData(
        count: 80,
        color: Color(0xffD7F4DF),
      ),
    ],
    spentsMetrics: [
      ChartData(
        count: 20,
        color: Color(0xffFEDD87),
      ),
      ChartData(
        count: 60,
        color: Color(0xFEDD874D),
      ),
    ],
  ),
];
