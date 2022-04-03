import '/models/appuser.dart';

abstract class BaseProfileRepository {
  Future<AppUser?> getCurrentUserProfile({
    required String? userId,
  });
}
