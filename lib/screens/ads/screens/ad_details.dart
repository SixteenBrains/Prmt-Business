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
    final _canvas = MediaQuery.of(context).size;
    // var numFormate = NumberFormat.currency(
    //   locale: 'HI',
    //   symbol: '₹ ',
    //   decimalDigits: 0,
    // );
    final today = DateTime.now();
    final remainingDays = ad?.endDate?.difference(today).inDays;
    // final int? budget =
    //     adModel?.budget != null ? int.tryParse(adModel!.budget!) : null;

    //int available = 2500;
    // final int? budget = ad?.budget != null ? int.tryParse(ad!.budget!) : null;

    //  final _dateFormate = DateFormat('dd MMM yyyy');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              ShowMedia(
                mediaUrl: ad?.mediaUrl,
                mediaType: ad?.adType ?? MediaType.none,
                height: _canvas.height * 0.5,
                fit: BoxFit.contain,
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
                    remainingDays != null
                        ? remainingDays < 0
                            ? 'Expired'
                            : '$remainingDays  Days Remaining'
                        : 'N/A',
                    //'${remainingDays ?? 'N/A'} Days Remaining',
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
              Text(
                ad?.description ?? '',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Promotes',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 400.0,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return const ListTile(
                      title: Text(
                        'Username',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'https://fontawesome.com/',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Text('Add Promoters')
            ],
          ),
        ),
      ),
    );
  }
}
