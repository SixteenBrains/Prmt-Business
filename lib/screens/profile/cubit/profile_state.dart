part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, succuss, error, imgUploaded }

class ProfileState extends Equatable {
  final AppUser? user;
  final ProfileStatus status;
  final Failure failure;
  final File? imageFile;
  final String? name;
  final String? stateName;
  final String? cityName;

  const ProfileState({
    required this.user,
    required this.status,
    required this.failure,
    this.stateName,
    this.name,
    this.cityName,
    this.imageFile,
  });

  factory ProfileState.initial() => const ProfileState(
      user: null, status: ProfileStatus.initial, failure: Failure());

  @override
  List<Object?> get props =>
      [user, failure, status, imageFile, name, cityName, stateName];

  ProfileState copyWith({
    AppUser? user,
    ProfileStatus? status,
    Failure? failure,
    File? imageFile,
    String? name,
    String? cityName,
    String? stateName,
  }) {
    return ProfileState(
      user: user ?? this.user,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      imageFile: imageFile ?? this.imageFile,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      name: name ?? this.name,
    );
  }

  @override
  String toString() =>
      'ProfileState(user: $user, status: $status, failure: $failure, imageFile: $imageFile)';
}
