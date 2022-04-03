import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/ad_model.dart';
import '/models/failure.dart';
import '/repositories/ad/base_ad_repo.dart';

class AdRepository extends BaseAdRepository {
  final FirebaseFirestore _firestore;

  AdRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> dratAd({
    required AdModel? ad,
    required String? userId,
  }) async {
    try {
      if (ad == null || userId == null) {
        return;
      }
      await _firestore
          .collection(Paths.drafts)
          .doc(userId)
          .collection(Paths.draftAds)
          .add(ad.toMap());
    } catch (error) {
      throw const Failure(message: 'Something went wrong, try again');
    }
  }
}
