import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/appuser.dart';
import '/models/business_type.dart';
import '/models/failure.dart';
import '/repositories/registraion/base_registration_repo.dart';

class RegistrationRepository extends BaseRegistrationRepo {
  final FirebaseFirestore _firestore;

  RegistrationRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> registerUser({required AppUser user}) async {
    try {
      await _firestore.collection(Paths.users).doc(user.uid).set(user.toMap());
    } catch (error) {
      print('Errorn in registration ${error.toString()}');
      throw const Failure(message: 'Error in user registration');
    }
  }

  Future<AppUser?> getCurrentUser({required String? uid}) async {
    try {
      final userSnap = await _firestore
          .collection(Paths.users)
          .doc(uid)
          .withConverter<AppUser>(
              fromFirestore: (snapshot, _) => AppUser.fromDocument(snapshot),
              toFirestore: (snapshot, _) => snapshot.toMap())
          .get();

      return userSnap.data();
    } catch (error) {
      print('Error in getting current user ${error.toString()}');
      throw const Failure(message: 'Error in getting current user');
    }
  }

  Future<List<BusinessType?>> getBusinessType() async {
    try {
      final typeSnaps = await _firestore.collection(Paths.businessTypes).get();
      return typeSnaps.docs
          .map((snap) => BusinessType.fromMap(snap.data()))
          .toList();
    } catch (error) {
      print('Error in getting business types ${error.toString()}');
      throw const Failure(message: 'Error in getting business types');
    }
  }
}
