import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prmt_business/screens/ad-details/ad_details.dart';
import '/constants/constants.dart';
import '/models/ad_model.dart';
import '/widgets/display_image.dart';

import 'show_pie_chart.dart';

class LiveAds extends StatelessWidget {
  const LiveAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Ads',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 35.0,
                width: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.blue, width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Sort',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2.0),
                    Icon(
                      Icons.expand_more,
                      color: Colors.blue,
                      size: 22.0,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: liveAds.length,
              itemBuilder: (context, index) {
                return LiveAdCard(
                  ad: liveAds[index],
                );
              },
            ),
          ),
          const SizedBox(height: 55.0),
        ],
      ),
    );
  }
}

class LiveAdCard extends StatelessWidget {
  final Ad? ad;

  const LiveAdCard({Key? key, this.ad}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var numFormate = NumberFormat.currency(
      locale: 'HI',
      symbol: '₹ ',
      decimalDigits: 0,
    );
    final _canvas = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AdDetails(ad: ad),
        ),
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
              child: Hero(
                tag: 'ad?.imageUrl',
                child: DisplayImage(
                  imageUrl: ad?.imageUrl,
                  height: _canvas.width * 0.5,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ad?.productName ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.alarm,
                        color: ad!.isNegative
                            ? const Color(0xffFD6F66)
                            : Colors.blue,
                        size: 20.0,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        ad?.timeRemaining ?? '',
                        style: TextStyle(
                            color: ad!.isNegative
                                ? const Color(0xffFD6F66)
                                : Colors.blue),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 80.0,
                        width: 140.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F4F9),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              numFormate.format(ad?.budget),
                              style: const TextStyle(
                                fontSize: 26.0,
                                color: Colors.black,
                                //fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Total Budget',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80.0,
                        width: 140.0,
                        decoration: BoxDecoration(
                          color: ad!.isNegative
                              ? const Color(0xffFFE2E0)
                              : const Color(0xffF4F4F9),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              numFormate.format(ad?.availableBalance),
                              style: const TextStyle(
                                fontSize: 26.0,
                                color: Colors.black,
                                //fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ShowPieChart(
                          chartData: ad?.clicksMetrics ?? [],
                          label: 'Clicks',
                          count: 103,
                        ),
                      ),

                      ///
                      Expanded(
                        child: ShowPieChart(
                          chartData: ad?.convertsMetrics ?? [],
                          label: 'Converts',
                          count: 12,
                        ),
                      ),
                      Expanded(
                        child: ShowPieChart(
                          chartData: ad?.spentsMetrics ?? [],
                          label: 'Spent',
                          count: 600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
