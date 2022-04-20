import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DynamicLinksService {
  static Future<String> createDynamicLink(
      {required String link, required String parameter}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.packageName);
    String uriPrefix = 'https://prmtbusiness.page.link';

    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse('$link$parameter'),
      androidParameters: AndroidParameters(
        packageName: packageInfo.packageName,
        minimumVersion: 125,
      ),
      iosParameters: IOSParameters(
        bundleId: packageInfo.packageName,
        minimumVersion: packageInfo.version,
        appStoreId: '123456789',
      ),
      googleAnalyticsParameters: const GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
      itunesConnectAnalyticsParameters: const ITunesConnectAnalyticsParameters(
        providerToken: '123456',
        campaignToken: 'example-promo',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Example of a Dynamic Link',
        description: 'This link works whether app is installed or not!',
        imageUrl: Uri.parse(
            'https://images.pexels.com/photos/3841338/pexels-photo-3841338.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
      ),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    // final Uri shortUrl = shortDynamicLink.shortUrl;
    // return shortUrl.toString();
    print('Generated dynamic link  $dynamicLink');
    print('Generated short dynamic link $shortDynamicLink');
    return dynamicLink.toString();
  }

  static void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDynamicLink(data);

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _handleDynamicLink(dynamicLinkData);
    }).onError((error) {
      print('Error in getting dynamic link ${error.toString()}');
    });
    // FirebaseDynamicLinks.instance.onLink(
    //     onSuccess: (PendingDynamicLinkData dynamicLink) async {
    //   _handleDynamicLink(dynamicLink);
    // }, onError: (OnLinkErrorException e) async {
    //   print('onLinkError');
    //   print(e.message);
    // });
  }

  static _handleDynamicLink(PendingDynamicLinkData? data) async {
    final Uri? deepLink = data?.link;

    if (deepLink == null) {
      return;
    }
    print('Deep link received $deepLink');
    print('Deep link received $deepLink');
    if (deepLink.pathSegments.contains('refer')) {
      var title = deepLink.queryParameters['code'];
      if (title != null) {
        print('refercode=$title');
      }
    }
  }
}
