import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '/config/paths.dart';
import '/models/ad_count.dart';
import '/models/failure.dart';

import '/repositories/stats/base_stats_repo.dart';

class StatsRepository extends BaseStatsRepository {
  final FirebaseFirestore _firestore;

  StatsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<AdCount?> getAdsCount() async {
    try {
      int liveAds = 0;
      int promotedAds = 0;
      int expiredAds = 0;

      final promotedAdsSnaps =
          await _firestore.collection(Paths.promotedAds).get();

      final today = Timestamp.fromDate(DateTime.now());
      final liveAdsSnaps = await _firestore
          .collection(Paths.ads)
          .where('endDate', isGreaterThanOrEqualTo: today)
          .get();

      final expiredAdsSnaps = await _firestore
          .collection(Paths.ads)
          .where('endDate', isLessThanOrEqualTo: today)
          .get();

      print('Prmotto ads an --- ${promotedAdsSnaps.docs.length}');
      for (var element in promotedAdsSnaps.docs) {
        debugPrint('User id --- ${element.id}');
        final adsSnaps = await _firestore
            .collection(Paths.promotedAds)
            .doc(element.id)
            .collection(Paths.ads)
            .get();
        promotedAds += adsSnaps.docs.length;
      }

      liveAds = liveAdsSnaps.docs.length;
      expiredAds = expiredAdsSnaps.docs.length;

      final adCount = AdCount(
        liveAdCount: liveAds,
        expiredAdCount: expiredAds,
        promotedAdCount: promotedAds,
      );
      return adCount;
    } catch (error) {
      print('Error getting promoted ads count ${error.toString()}');
      throw const Failure(message: 'Error in getting promoted ads count');
    }
  }

  Future<int?> getBussinessUsersCount() async {
    try {
      final usersSnaps = await _firestore.collection(Paths.users).get();
      return usersSnaps.docs.length;
    } catch (error) {
      print('Error in getting bussiness count ${error.toString()}');
      throw const Failure(message: 'Error in getting bussiness count ');
    }
  }

  Future<int?> getPromotersCount() async {
    try {
      final usersSnaps = await _firestore.collection(Paths.promoters).get();
      return usersSnaps.docs.length;
    } catch (error) {
      print('Error in getting bussiness count ${error.toString()}');
      throw const Failure(message: 'Error in getting bussiness count ');
    }
  }
}
