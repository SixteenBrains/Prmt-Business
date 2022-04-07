import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prmt_business/screens/ad-details/ad_details.dart';
import 'package:prmt_business/widgets/loading_indicator.dart';
import 'package:prmt_business/widgets/sort_ads.dart';
import '/models/ad_model.dart';
import '/models/chart_data.dart';
import '/screens/dashboard/cubit/ads_cubit.dart';
import '/widgets/display_image.dart';
import 'show_pie_chart.dart';

class ExpiredAds extends StatelessWidget {
  const ExpiredAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsCubit, AdsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == AdStatus.loading) {
          return const LoadingIndicator();
        }
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
                  SortAds(onChanged: () {
                    context.read<AdsCubit>().toogleRecent();
                  }),
                ],
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: state.ads.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () async {
                          context.read<AdsCubit>().loadExpiredAds();
                        },
                        child: ListView.builder(
                          itemCount: state.ads.length,
                          itemBuilder: (context, index) {
                            return ExpiredCard(
                              adModel: state.ads[index],
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Text(
                          'You don\'t have any expired ads',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
              ),
              const SizedBox(height: 55.0),
            ],
          ),
        );
      },
    );
  }
}

class ExpiredCard extends StatelessWidget {
  final AdModel? adModel;

  const ExpiredCard({
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
    final _canvas = MediaQuery.of(context).size;

    //final today = DateTime.now();
    //final remainingDays = adModel?.endDate?.difference(today).inDays;
    final int? budget =
        adModel?.budget != null ? int.tryParse(adModel!.budget!) : null;
    // int availableBalance = 2500;
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
              child: Hero(
                tag: adModel?.adId ?? 'AdImage',
                child: DisplayImage(
                  imageUrl: adModel?.mediaUrl,
                  height: _canvas.height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.contain,
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
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: adModel?.title ?? 'N/A',
                        ),
                        const TextSpan(
                          text: ' (Expired)',
                          style: TextStyle(color: Color(0xffFD6F66)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Icon(
                  //       Icons.alarm,
                  //       color: ad!.isNegative
                  //           ? const Color(0xffFD6F66)
                  //           : Colors.blue,
                  //       size: 20.0,
                  //     ),
                  //     const SizedBox(width: 5.0),
                  //     Text(
                  //       ad?.timeRemaining ?? '',
                  //       style: TextStyle(
                  //           color: ad!.isNegative
                  //               ? const Color(0xffFD6F66)
                  //               : Colors.blue),
                  //     )
                  //   ],
                  // ),
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
                          color: const Color(0xffFFE2E0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              numFormate.format(0),
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
                              //count: (adModel?.stats?.clicks ?? 1).toDouble(),
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
                          //count: adModel?.stats?.clicks ?? 0,
                        ),
                      ),

                      ///
                      Expanded(
                        child: ShowPieChart(
                          chartData: [
                            ChartData(
                              count: 1,
                              //count: (adModel?.stats?.converts ?? 1).toDouble(),
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
