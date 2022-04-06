import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_business/widgets/sort_ads.dart';
import '/screens/dashboard/cubit/ads_cubit.dart';
import '/widgets/loading_indicator.dart';
import 'live_ad_card.dart';

class LiveAdsTab extends StatelessWidget {
  const LiveAdsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsCubit, AdsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == AdStatus.succuss) {
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
                    // Container(
                    //   height: 35.0,
                    //   width: 80.0,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(6.0),
                    //     border: Border.all(color: Colors.blue, width: 1.5),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: const [
                    //       Text(
                    //         'Sort',
                    //         style: TextStyle(
                    //           fontSize: 16.0,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //       SizedBox(width: 2.0),
                    //       Icon(
                    //         Icons.expand_more,
                    //         color: Colors.blue,
                    //         size: 22.0,
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<AdsCubit>().loadLiveAds();
                    },
                    child: ListView.builder(
                      // reverse: state.showRecent,
                      itemCount: state.ads.length,
                      itemBuilder: (context, index) {
                        return LiveAdCard(
                          //  ad: state.liveAds[index],
                          adModel: state.ads[index],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 55.0),
              ],
            ),
          );
        }
        return const LoadingIndicator();
      },
    );
  }
}
