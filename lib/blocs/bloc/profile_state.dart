part of 'profile_bloc.dart';

enum ProfileStatus { initial, profileCreated, error }

class ProfileState extends Equatable {
  final AppUser? appUser;
  final ProfileStatus status;
  final Failure failure;

  const ProfileState({
    required this.appUser,
    required this.status,
    required this.failure,
  });

  factory ProfileState.initial() => const ProfileState(
      appUser: null, status: ProfileStatus.initial, failure: Failure());

  @override
  List<Object?> get props => [appUser, status, failure];

  ProfileState copyWith({
    AppUser? appUser,
    ProfileStatus? status,
    Failure? failure,
  }) {
    return ProfileState(
      appUser: appUser ?? this.appUser,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
