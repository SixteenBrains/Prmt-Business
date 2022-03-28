import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prmt_business/config/paths.dart';
import 'package:prmt_business/models/appuser.dart';
import 'package:prmt_business/models/failure.dart';
import 'package:prmt_business/repositories/registraion/base_registration_repo.dart';

class RegistrationRepository extends BaseRegistrationRepo {
  final FirebaseFirestore _firestore;

  RegistrationRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> registerUser({required AppUser user}) async {
    try {
      await _firestore.collection(Paths.users).add(user.toMap());
    } catch (error) {
      print('Errorn in registration ${error.toString()}');
      throw const Failure(message: 'Error in user registration');
    }
  }
}
