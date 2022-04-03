import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_business/repositories/profile/profile_repo.dart';
import '/models/appuser.dart';
import '/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late StreamSubscription<AppUser?> _userSubscription;
  final ProfileRepository _profileRepository;

  AuthBloc({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  })  : _authRepository = authRepository,
        _profileRepository = profileRepository,
        super(AuthState.unknown()) {
    _userSubscription = _authRepository.onAuthChanges.listen(
      (user) async {
        final appUser =
            await _profileRepository.getCurrentUserProfile(userId: user?.uid);
        add(AuthUserChanged(user: appUser));
      },
    );
    on<AuthEvent>((event, emit) async {
      if (event is AuthUserChanged) {
        emit(
          event.user != null
              ? AuthState.authenticated(user: event.user)
              : AuthState.unAuthenticated(),
        );
      } else if (event is AuthLogoutRequested) {
        await _authRepository.signOut();
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
