import 'package:flutter/material.dart';
import '/enums/media_type.dart';
import '/models/ad_model.dart';
import '/widgets/show_media.dart';

class AdsDetailsArgs {
  final AdModel? ad;

  AdsDetailsArgs({required this.ad});
}

class AdDetails extends StatelessWidget {
  static const String routeName = '/ad-details';

  const AdDetails({Key? key, required this.ad}) : super(key: key);

  final AdModel? ad;

  static Route route({required AdsDetailsArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AdDetails(ad: args.ad),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            ShowMedia(
              mediaUrl: ad?.mediaUrl,
              mediaType: ad?.adType ?? MediaType.none,
            ),
            const SizedBox(height: 15.0),
            Text(
              ad?.title ?? 'N/A',
              style: const TextStyle(
                fontSize: 17.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              ad?.description ?? '',
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
