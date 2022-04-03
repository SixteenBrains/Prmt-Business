import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/appuser.dart';
import '/models/failure.dart';
import '/repositories/profile/base_profile_repo.dart';

class ProfileRepository extends BaseProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<AppUser?> getCurrentUserProfile({
    required String? userId,
  }) async {
    try {
      if (userId == null) {
        return null;
      }
      final userSnaps =
          await _firestore.collection(Paths.users).doc(userId).get();
      return AppUser.fromDocument(userSnaps);
    } catch (error) {
      print('Error getting current profile user ${error.toString()}');
      throw const Failure(message: 'Error getting current user profile');
    }
  }
}
