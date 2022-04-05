import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/chart_data.dart';

import '/models/ad_model.dart';
import '/screens/payment/widgets/top_up.dart';
import '/widgets/bottom_nav_button.dart';
import '/screens/dashboard/widgets/show_pie_chart.dart';
import '/widgets/display_image.dart';
import 'widgets/social_metirics.dart';

class AdDetailsArgs {
  final AdModel? adModel;

  AdDetailsArgs({required this.adModel});
}

class AdDetails extends StatelessWidget {
  static const String routeName = '/ad-details';

  final AdModel? adModel;

  static Route route({required AdDetailsArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AdDetails(
        adModel: args.adModel,
      ),
    );
  }

  const AdDetails({
    Key? key,
    required this.adModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    var numFormate = NumberFormat.currency(
      locale: 'HI',
      symbol: '₹ ',
      decimalDigits: 0,
    );
    final today = DateTime.now();
    final remainingDays = adModel?.endDate?.difference(today).inDays;
    // final int? budget =
    //     adModel?.budget != null ? int.tryParse(adModel!.budget!) : null;

    int available = 2500;
    final int? budget =
        adModel?.budget != null ? int.tryParse(adModel!.budget!) : null;

    final _dateFormate = DateFormat('dd MMM yyyy');
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        title: const Text('Nivea Men'),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'ad?.imageUrl',
                  child: DisplayImage(
                    imageUrl: adModel?.mediaUrl,
                    height: _canvas.height * 0.3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    //fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        adModel?.name ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
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
                            size: 20.0,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            '${remainingDays ?? 'N/A'} Days Remaining',
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
                      Container(
                        height: 45.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFE2E0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20.0),
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 10.0),
                            Row(
                              children: [
                                Text(
                                  adModel?.startDate != null
                                      ? _dateFormate.format(adModel!.startDate!)
                                      : 'N/A',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  ' - ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  adModel?.startDate != null
                                      ? _dateFormate.format(adModel!.endDate!)
                                      : 'N/A',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 80.0,
                            width: 160.0,
                            decoration: BoxDecoration(
                              color: const Color(0xffF4F4F9),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  numFormate.format(budget),
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
                          GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const TopUp(),
                            )),
                            child: Container(
                              height: 80.0,
                              width: 160.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffFD6F66)),
                                // color: ad!.isNegative
                                //     ? const Color(0xffFFE2E0)
                                //     : const Color(0xffF4F4F9),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    numFormate.format(available),
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
                              chartData: [
                                ChartData(
                                  count:
                                      (adModel?.stats?.clicks ?? 1).toDouble(),
                                  color: const Color(0xff19CED7),
                                ),
                                const ChartData(
                                  count: 50,
                                  color: Color(0xffC6F3F5),
                                ),
                              ],
                              //  chartData: ad?.clicksMetrics ?? [],
                              label: 'Clicks',
                              count: adModel?.stats?.clicks ?? 0,
                            ),
                          ),

                          ///
                          Expanded(
                            child: ShowPieChart(
                              chartData: [
                                ChartData(
                                  count: (adModel?.stats?.converts ?? 0)
                                      .toDouble(),
                                  color: const Color(0xff7CDA94),
                                ),
                                const ChartData(
                                  count: 50,
                                  color: Color(0xffD7F4DF),
                                ),
                              ],
                              label: 'Converts',
                              count: adModel?.stats?.converts ?? 0,
                            ),
                          ),
                          Expanded(
                            child: ShowPieChart(
                              chartData: [
                                ChartData(
                                  count:
                                      (adModel?.stats?.spent ?? 0).toDouble(),
                                  color: const Color(0xFEDD874D),
                                ),
                                const ChartData(
                                  count: 50,
                                  color: Color(0xffFEDD87),
                                ),
                              ],
                              label: 'Spent',
                              count: adModel?.stats?.spent ?? 0,
                            ),
                          ),
                          // Expanded(
                          //   child: ShowPieChart(
                          //     chartData: ad?.clicksMetrics ?? [],
                          //     label: 'Clicks',
                          //     count: 103,
                          //   ),
                          // ),

                          // ///
                          // Expanded(
                          //   child: ShowPieChart(
                          //     chartData: ad?.convertsMetrics ?? [],
                          //     label: 'Converts',
                          //     count: 12,
                          //   ),
                          // ),
                          // Expanded(
                          //   child: ShowPieChart(
                          //     chartData: ad?.spentsMetrics ?? [],
                          //     label: 'Spent',
                          //     count: 600,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Text(adModel?.description ?? 'N/A'),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Target Link',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        adModel?.targetLink != null
                            ? adModel!.targetLink!.length > 100
                                ? adModel!.targetLink!.substring(0, 100) +
                                    '  ...'
                                : 'N/A'
                            : 'N/A',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: const [
                                Text(
                                  'Clicks from social media',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const SocialMetirics(
                          label: 'Whatsapp',
                          color: Color(0xff1FCFB8),
                          percent: 60,
                        ),
                        const SocialMetirics(
                          label: 'Instagram',
                          color: Color(0xffF86348),
                          percent: 20,
                        ),
                        const SocialMetirics(
                          label: 'Facebook',
                          color: Color(0xff0F81D5),
                          percent: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    // vertical: 20.0,
                  ),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: const [
                                Text(
                                  'Conversion from social media',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const SocialMetirics(
                          label: 'Whatsapp',
                          color: Color(0xff1FCFB8),
                          percent: 80,
                        ),
                        const SocialMetirics(
                          label: 'Instagram',
                          color: Color(0xffF86348),
                          percent: 30,
                        ),
                        const SocialMetirics(
                          label: 'Facebook',
                          color: Color(0xff0F81D5),
                          percent: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
          //         Positioned(
          //           left: 10.0,
          //           right: 10.0,
          //           bottom: 90.0,
          //           child: BubbleShowcase(
          // bubbleShowcaseId: 'my_bubble_showcase',
          // bubbleShowcaseVersion: 1,
          // bubbleSlides: [
          //   RelativeBubbleSlide(
          //     widgetKey: widgetToHighlightKey,
          //     child: RelativeBubbleSlideChild(
          //       direction: AxisDirection.right,
          //       widget: SpeechBubble(
          //         nipLocation: NipLocation.LEFT,
          //         color: Colors.blue,
          //         child: Padding(
          //           padding: EdgeInsets.all(10),
          //           child: Text(
          //             'This is a new cool feature !',
          //             style: TextStyle(color: Colors.white),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),

          // Container(
          //   height: 100.0,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: const Color(0xffFFFAE2),
          //     borderRadius: BorderRadius.circular(4.0),
          //   ),
          // ),
          //),
          Positioned(
            left: 10.0,
            right: 10.0,
            bottom: -0.9,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
              child: BottomNavButton(
                label: 'CREATE NEW AD',
                isEnabled: true,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
