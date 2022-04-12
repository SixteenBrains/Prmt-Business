import '../../models/admin_user.dart';

abstract class BaseAuthRepository {
  Future<AdminUser?> get currentUser;
  Stream<AdminUser?> get onAuthChanges;
  Future<void>? forgotPassword({String? email});
  Future<void> signOut();
}
