import 'package:flutter/material.dart';
import 'package:prmt_business/constants/drafs_ads_const.dart';
import 'package:prmt_business/models/draft_ad.dart';
import 'package:prmt_business/widgets/display_image.dart';

class DrafAds extends StatelessWidget {
  const DrafAds({Key? key}) : super(key: key);

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
                'Draft Ads',
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
                itemCount: draftsAds.length,
                itemBuilder: (context, index) {
                  return DraftAdsCard(
                    draftAd: draftsAds[index],
                  );
                }),
          ),
          const SizedBox(height: 55.0),
        ],
      ),
    );
  }
}

class DraftAdsCard extends StatelessWidget {
  final DraftAd? draftAd;

  const DraftAdsCard({Key? key, this.draftAd}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
            child: DisplayImage(
              imageUrl: draftAd?.imageUrl,
              height: _canvas.width * 0.5,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  draftAd?.productName ?? 'N/A',
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
                      color: draftAd!.isNegative
                          ? const Color(0xffFD6F66)
                          : Colors.blue,
                      size: 20.0,
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      draftAd?.remainingTime ?? '',
                      style: TextStyle(
                          color: draftAd!.isNegative
                              ? const Color(0xffFD6F66)
                              : Colors.blue),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
