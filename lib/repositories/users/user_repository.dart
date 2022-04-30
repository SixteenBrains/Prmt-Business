import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/bussiness_user.dart';
import '/models/failure.dart';
import '/models/promoter.dart';
import '/config/paths.dart';
import '/repositories/users/base_user_repo.dart';

class UserRepository extends BaseUsersRepo {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<BussinessUser?>> getBussinessUsers() async {
    try {
      final userSnaps = await _firestore.collection(Paths.users).get();
      return userSnaps.docs
          .map((doc) => BussinessUser.fromDocument(doc))
          .toList();
    } catch (error) {
      print('Error in gettin bussiness users');
      throw const Failure(message: 'Error in getting bussiness users');
    }
  }

  Future<List<Promoter?>> getPromoters() async {
    try {
      final promoterSnaps = await _firestore.collection(Paths.promoters).get();

      return promoterSnaps.docs
          .map((doc) => Promoter.fromDocument(doc))
          .toList();
    } catch (error) {
      print('Error in promoter ${error.toString()}');
      throw const Failure(message: 'Error in getting promoters');
    }
  }
}
