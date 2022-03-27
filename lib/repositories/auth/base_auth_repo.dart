import '/models/appuser.dart';

abstract class BaseAuthRepository {
  Future<AppUser?> get currentUser;
  Stream<AppUser?> get onAuthChanges;
  Future<void>? forgotPassword({String? email});
  Future<void> signOut();
}
