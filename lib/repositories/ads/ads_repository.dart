import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prmt_admin/config/paths.dart';
import 'package:prmt_admin/models/ad_model.dart';
import 'package:prmt_admin/models/failure.dart';
import 'package:prmt_admin/repositories/ads/base_ads_repo.dart';

class AdsRepository extends BaseAdsRepo {
  final FirebaseFirestore _firestore;

  AdsRepository({FirebaseFirestore? firestore})
      : _firestore = FirebaseFirestore.instance;

  Future<List<Future<AdModel?>>> liveAds() async {
    try {
      final ads = await _firestore.collection(Paths.ads).get();

      for (var element in ads.docs) {
        AdModel.fromMap(element);
      }

      return ads.docs.map((doc) => AdModel.fromMap(doc)).toList();
    } catch (error) {
      throw const Failure(message: 'Error in getting live ads');
    }
  }
}
