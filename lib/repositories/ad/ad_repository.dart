import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/ad_stats.dart';
import '/models/ad_model.dart';
import '/config/paths.dart';
import '/models/failure.dart';
import '/repositories/ad/base_ad_repo.dart';
import 'package:http/http.dart' as http;

class AdRepository extends BaseAdRepository {
  final FirebaseFirestore _firestore;

  AdRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Get

  Future<List<Future<AdModel?>>> getLiveAds({
    required String? userId,
    required bool showRecent,
  }) async {
    try {
      final today = Timestamp.fromDate(DateTime.now());
      final authorRef = _firestore.collection(Paths.users).doc(userId);

      final adsSnaps = await _firestore
          .collection(Paths.ads)
          .where('author', isEqualTo: authorRef)
          .where('endDate', isGreaterThanOrEqualTo: today)
          .get();

      return adsSnaps.docs.map((doc) => AdModel.fromDocument(doc)).toList();
    } catch (error) {
      print('Error getting live ads ${error.toString()}');
      throw const Failure(message: 'Error getting live ads');
    }
  }

  Future<List<Future<AdModel?>>> getExpiredAds(
      {required String? userId}) async {
    try {
      final today = Timestamp.fromDate(DateTime.now());
      final authorRef = _firestore.collection(Paths.users).doc(userId);

      final adsSnaps = await _firestore
          .collection(Paths.ads)
          .where('author', isEqualTo: authorRef)
          .where('endDate', isLessThan: today)
          //.orderBy('endDate', descending: true)
          .get();

      return adsSnaps.docs.map((doc) => AdModel.fromDocument(doc)).toList();
    } catch (error) {
      print('Error getting live ads ${error.toString()}');
      throw const Failure(message: 'Error getting live ads');
    }
  }

  Future<AdModel?> getAdDetails({required String? adId}) async {
    try {
      if (adId == null) {
        return null;
      }
      final adSnap = await _firestore.collection(Paths.ads).doc(adId).get();

      return await AdModel.fromDocument(adSnap);
    } catch (error) {
      print('Error getting ad details ${error.toString()}');
      throw const Failure(message: 'Error in getting ad details');
    }
  }

  Future<List<Future<AdModel?>>> getUserDraftAds({
    required String? userID,
  }) async {
    try {
      if (userID == null) {
        return [];
      }

      final adSnaps = await _firestore
          .collection(Paths.drafts)
          .doc(userID)
          .collection(Paths.draftAds)
          .orderBy('startDate', descending: true)
          .get();

      return adSnaps.docs.map((doc) => AdModel.fromDocument(doc)).toList();
    } catch (error) {
      print('Error in getting draft ads');
      throw const Failure(message: 'Error in getting draft ads');
    }
  }

  // Post

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
      print('Error in draft ad ${error.toString()}');
      throw const Failure(message: 'Something went wrong, try again');
    }
  }

  Future<int?> getUserTotalAds({required String? userId}) async {
    try {
      if (userId == null) {
        return null;
      }
      final authorRef = _firestore.collection(Paths.users).doc(userId);
      final adsSnaps = await _firestore
          .collection(Paths.ads)
          .where('author', isEqualTo: authorRef)
          .get();

      return adsSnaps.docs.length;
    } catch (error) {
      print('Error in getting user total ads ${error.toString()}');
      throw const Failure(message: 'Error in getting user total ads');
    }
  }

  Future<String?> publishAd({
    required AdModel? ad,
    required String? userId,
  }) async {
    try {
      if (ad == null || userId == null) {
        return null;
      }

      final docRef = await _firestore.collection(Paths.ads).add(ad.toMap());

      await _firestore
          .collection(Paths.stats)
          .doc(docRef.id)
          .set(AdStats.emptyStats().toMap());
      return docRef.id;
    } catch (error) {
      print('Error in draft ad ${error.toString()}');
      throw const Failure(message: 'Something went wrong, try again');
    }
  }

  Future<List<String>> getStateCities({required String state}) async {
    try {
      List<String> stateCities = [];
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      String url =
          'https://countriesnow.space/api/v0.1/countries/state/cities/q?country=India&state=$state';

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          final List cities = data['data'] ?? [];

          for (var element in cities) {
            if (element != null) {
              stateCities.add(element);
            }
          }
        }
      }
      return stateCities;
    } catch (error) {
      print('Error getting state cities ${error.toString()}');
      throw const Failure(message: 'Error getting cities');
    }
  }
}
