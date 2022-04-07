import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/repositories/profile/profile_repo.dart';
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
        add(
          AuthUserChanged(
            user: user?.copyWith(
              //Skipping phone number and userId

              profileImg: appUser?.profileImg,
              createdAt: appUser?.createdAt,
              state: appUser?.state,
              city: appUser?.city,
              name: appUser?.name,
              email: appUser?.email,
              businessName: appUser?.businessName,
              businessType: appUser?.businessType,
            ),
          ),
        );
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
      } else if (event is UserProfileImageChanged) {
        emit(state.copyWith(
            user: state.user?.copyWith(profileImg: event.imgUrl)));
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
