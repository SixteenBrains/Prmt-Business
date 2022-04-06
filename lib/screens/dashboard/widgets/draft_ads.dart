import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/ad_model.dart';
import '/screens/ad-details/ad_details.dart';
import '/widgets/sort_ads.dart';
import '/screens/dashboard/cubit/ads_cubit.dart';
import '/widgets/loading_indicator.dart';
import '/constants/drafs_ads_const.dart';
import '/models/draft_ad.dart';
import '/widgets/display_image.dart';

class DrafAds extends StatelessWidget {
  const DrafAds({Key? key}) : super(key: key);

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
                      'Draft Ads',
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
                  child: ListView.builder(
                    itemCount: state.ads.length,
                    itemBuilder: (context, index) {
                      return DraftAdsCard(
                        draftAd: draftsAds[index],
                        adModel: state.ads[index],
                      );
                    },
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

class DraftAdsCard extends StatelessWidget {
  final DraftAd? draftAd;
  final AdModel? adModel;

  const DraftAdsCard({
    Key? key,
    this.draftAd,
    required this.adModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    final today = DateTime.now();
    final remainingDays = adModel?.endDate?.difference(today).inDays;
    // final int? budget =
    //     adModel?.budget != null ? int.tryParse(adModel!.budget!) : null;
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
                  height: _canvas.height * 0.3,
                  width: double.infinity,
                  // fit: BoxFit.fitHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adModel?.title ?? 'N/A',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
