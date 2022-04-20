import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prmt_business/screens/dashboard/dashboard.dart';
import '/enums/enums.dart';
import '/models/chart_data.dart';
import '/screens/dashboard/widgets/show_media.dart';
import '/screens/dashboard/widgets/show_pie_chart.dart';
import '/screens/payment/widgets/top_up.dart';
import '/widgets/loading_indicator.dart';
import '/repositories/ad/ad_repository.dart';
import '/screens/ad-details/cubit/ad_details_cubit.dart';
import 'widgets/social_metirics.dart';

class AdIdDetailsArgs {
  final String? adId;

  AdIdDetailsArgs({required this.adId});
}

class AdDetailsFromId extends StatelessWidget {
  static const String routeName = '/adDetailsFromId';
  const AdDetailsFromId({Key? key}) : super(key: key);

  static Route route({required AdIdDetailsArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => AdDetailsCubit(
          adRepository: context.read<AdRepository>(),
        )..fetchAdDetailsFromId(adId: args.adId),
        child: const AdDetailsFromId(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdDetailsCubit, AdDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == AdDetailsStatus.succuss) {
          // final _canvas = MediaQuery.of(context).size;

          final ad = state.ad;
          var numFormate = NumberFormat.currency(
            locale: 'HI',
            symbol: '₹ ',
            decimalDigits: 0,
          );
          final today = DateTime.now();
          final remainingDays = ad?.endDate?.difference(today).inDays;
          // final int? budget =
          //     adModel?.budget != null ? int.tryParse(adModel!.budget!) : null;

          int available = 2500;
          final int? budget =
              ad?.budget != null ? int.tryParse(ad!.budget!) : null;

          final _dateFormate = DateFormat('dd MMM yyyy');
          final adTitle = ad?.title != null
              ? ad!.title!.length > 30
                  ? ad.title!.substring(0, 30) + '...'
                  : ad.title
              : 'N/A';

          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  DashBoard.routeName, (route) => false);
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          DashBoard.routeName, (route) => false),
                ),
                elevation: 0.0,
                iconTheme: const IconThemeData(color: Colors.black),
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
                title: Text(adTitle ?? ''),
                backgroundColor: Colors.white,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0),
                    ShowMedia(
                      mediaUrl: ad?.mediaUrl,
                      mediaType: ad?.adType ?? MediaType.none,
                    ),
                    // Hero(
                    //   tag: adModel?.adId ?? 'AdImage',
                    //   child: DisplayImage(
                    //     imageUrl: adModel?.mediaUrl,
                    //     height: _canvas.height * 0.3,
                    //     width: double.infinity,
                    //     fit: BoxFit.contain,
                    //     //fit: BoxFit.fitHeight,
                    //   ),
                    // ),
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
                            ad?.title ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
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
                                      ad?.startDate != null
                                          ? _dateFormate.format(ad!.startDate!)
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
                                      ad?.startDate != null
                                          ? _dateFormate.format(ad!.endDate!)
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
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (_) => const TopUp(),
                                )),
                                child: Container(
                                  height: 80.0,
                                  width: 160.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffFD6F66)),
                                    // color: ad!.isNegative
                                    //     ? const Color(0xffFFE2E0)
                                    //     : const Color(0xffF4F4F9),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            children: const [
                              Expanded(
                                child: ShowPieChart(
                                  chartData: [
                                    ChartData(
                                      count: 1,
                                      // count:
                                      //     (adModel?.stats?.clicks ?? 1).toDouble(),
                                      color: Color(0xff19CED7),
                                    ),
                                    ChartData(
                                      count: 1,
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
                                      // count: (adModel?.stats?.converts ?? 0)
                                      //  .toDouble(),
                                      color: Color(0xff7CDA94),
                                    ),
                                    ChartData(
                                      count: 50,
                                      color: Color(0xffD7F4DF),
                                    ),
                                  ],
                                  label: 'Converts',
                                  count: 1,
                                  // count: adModel?.stats?.converts ?? 0,
                                ),
                              ),
                              Expanded(
                                child: ShowPieChart(
                                  chartData: [
                                    ChartData(
                                      count: 1,
                                      // (adModel?.stats?.spent ?? 0).toDouble(),
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
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0,
                      ),
                      child: Text(ad?.description ?? 'N/A'),
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
                            ad?.targetLink != null
                                ? ad!.targetLink!.length > 100
                                    ? ad.targetLink!.substring(0, 100) + '  ...'
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
            ),
          );
        }

        return const Scaffold(body: LoadingIndicator());
      },
    );
  }
}
