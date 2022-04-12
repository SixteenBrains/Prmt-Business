import 'package:cloud_firestore/cloud_firestore.dart';
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
