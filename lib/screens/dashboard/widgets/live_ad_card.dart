import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/enums/enums.dart';
import '/models/ad_model.dart';
import '/models/chart_data.dart';
import '/screens/ad-details/ad_details.dart';
import 'show_media.dart';
import 'show_pie_chart.dart';

class LiveAdCard extends StatelessWidget {
  final AdModel? adModel;

  const LiveAdCard({
    Key? key,
    required this.adModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var numFormate = NumberFormat.currency(
      locale: 'HI',
      symbol: '₹ ',
      decimalDigits: 0,
    );

    //final _canvas = MediaQuery.of(context).size;
    final today = DateTime.now();
    final remainingDays = adModel?.endDate?.difference(today).inDays;
    final int? budget =
        adModel?.budget != null ? int.tryParse(adModel!.budget!) : null;
    int availableBalance = 2500;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AdDetails.routeName,
          arguments: AdDetailsArgs(adModel: adModel)),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
              child: ShowMedia(
                mediaType: adModel?.adType ?? MediaType.none,
                mediaUrl: adModel?.mediaUrl,
              ),
            ),

            // ClipRRect(
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(4.0),
            //     topRight: Radius.circular(4.0),
            //   ),
            //   child: Hero(
            //     tag: adModel?.adId ?? 'AdImage',
            //     child: DisplayImage(
            //       imageUrl: adModel?.mediaUrl,
            //       height: _canvas.height * 0.25,
            //       width: double.infinity,
            //       fit: BoxFit.contain,
            //       //fit: BoxFit.fitHeight,
            //     ),
            //   ),
            // ),
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
                    adModel?.name ?? 'N/A',
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
                        color: remainingDays != null
                            ? remainingDays < 2
                                ? const Color(0xffFD6F66)
                                : Colors.blue
                            : Colors.grey,

                        // ad!.isNegative
                        // ? const Color(0xffFD6F66)
                        // : Colors.blue,
                        size: 20.0,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        '${remainingDays ?? 'N/A'} Days Remaining',
                        //ad?.timeRemaining ?? '',
                        style: TextStyle(
                          color: remainingDays != null
                              ? remainingDays < 2
                                  ? const Color(0xffFD6F66)
                                  : Colors.blue
                              : Colors.grey,
                        ),
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
                              budget != null
                                  ? numFormate.format(budget)
                                  : 'N/A',
                              //numFormate.format(budget),
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
                          color: availableBalance < 500
                              ? const Color(0xffFFE2E0)
                              : const Color(0xffF4F4F9),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              numFormate.format(availableBalance),
                              // numFormate.format(ad?.availableBalance),
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
                    children: const [
                      Expanded(
                        child: ShowPieChart(
                          chartData: [
                            ChartData(
                              count: 1,
                              //  count: (adModel?.stats?.clicks ?? 1).toDouble(),
                              color: Color(0xff19CED7),
                            ),
                            ChartData(
                              count: 50,
                              color: Color(0xffC6F3F5),
                            ),
                          ],
                          //  chartData: ad?.clicksMetrics ?? [],
                          label: 'Clicks',
                          count: 1,
                          // count: adModel?.stats?.clicks ?? 0,
                        ),
                      ),

                      ///
                      Expanded(
                        child: ShowPieChart(
                          chartData: [
                            ChartData(
                              count: 1,
                              // count: (adModel?.stats?.converts ?? 1).toDouble(),
                              color: Color(0xff7CDA94),
                            ),
                            ChartData(
                              count: 50,
                              color: Color(0xffD7F4DF),
                            ),
                          ],
                          label: 'Converts',
                          count: 1,
                          //count: adModel?.stats?.converts ?? 1,
                        ),
                      ),
                      Expanded(
                        child: ShowPieChart(
                          chartData: [
                            ChartData(
                              count: 1,
                              // count: (adModel?.stats?.spent ?? 1).toDouble(),
                              color: Color(0xFEDD874D),
                            ),
                            ChartData(
                              count: 50,
                              color: Color(0xffFEDD87),
                            ),
                          ],
                          label: 'Spent',
                          count: 1,
                          //count: adModel?.stats?.spent ?? 0,
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
