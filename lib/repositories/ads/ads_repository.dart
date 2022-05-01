import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prmt_admin/models/ad_data.dart';
import 'package:prmt_admin/models/promoted_ad.dart';
import 'package:prmt_admin/models/promoter.dart';
import '/config/paths.dart';
import '/models/ad_model.dart';
import '/models/failure.dart';
import '/repositories/ads/base_ads_repo.dart';

class AdsRepository extends BaseAdsRepo {
  final FirebaseFirestore _firestore;

  AdsRepository({FirebaseFirestore? firestore})
      : _firestore = FirebaseFirestore.instance;

  Future<List<Future<AdModel?>>> getAds() async {
    try {
      final adsSnaps = await _firestore.collection(Paths.ads).get();
      return adsSnaps.docs.map((doc) => AdModel.fromDocument(doc)).toList();
    } catch (error) {
      print('Error in getting live ads ${error.toString()}');
      throw const Failure(message: 'Error in getting live ads');
    }
  }

  Future<List<AdData?>> getAdData({required String? adId}) async {
    try {
      if (adId == null) {
        return [];
      }

      //  List<Promoter?> promoters = [];
      List<AdData?> adData = [];
      final promotersSnaps = await _firestore
          .collection(Paths.ads)
          .doc(adId)
          .collection(Paths.promoters)
          .get();
      for (var element in promotersSnaps.docs) {
        final promoterDoc =
            _firestore.collection(Paths.promoters).doc(element.id);
        final promoterSnap = await promoterDoc.get();

        final promotedAdSnap = await _firestore
            .collection(Paths.promotedAds)
            .doc(element.id)
            .collection(Paths.ads)
            .doc(adId)
            .get();

        final ad = AdData(
            promoter: Promoter.fromDocument(promoterSnap),
            promotedAd: PromotedAd.fromDocument(promotedAdSnap));
        adData.add(ad); // promoters.add(Promoter.fromDocument(promoterSnap));
      }
      return adData;
    } catch (error) {
      print('Error in getting ad promoters ${error.toString()}');
      throw const Failure(message: 'Error in getting ad promoters');
    }
  }

  // Future getPromoters({required String? adId}) async {
  //   try {
  //     final adSnaps =
  //         await _firestore.collection('promotedAds').doc(adId).get();

  //     final adData = adSnaps.data();

  //     final promoters = adData?['promoters'] as List?;
  //   } catch (error) {
  //     print('Error in getting promoters ${error.toString()}');
  //   }
  // }

  // Future<List<Future<AdModel?>>> liveAds() async {
  //   try {
  //     final ads = await _firestore.collection(Paths.ads).get();

  //     for (var element in ads.docs) {
  //       AdModel.fromMap(element);
  //     }

  //     return ads.docs.map((doc) => AdModel.fromMap(doc)).toList();
  //   } catch (error) {
  //     throw const Failure(message: 'Error in getting live ads');
  //   }
  // }
}
