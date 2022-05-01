part of 'users_cubit.dart';

enum UserStatus { initial, loading, succuss, error }

class UsersState extends Equatable {
  final List<Promoter?> promoters;
  final Failure failure;
  final UserStatus status;
  final List<BussinessUser?> bussinessUsers;

  const UsersState({
    required this.promoters,
    required this.failure,
    required this.status,
    required this.bussinessUsers,
  });

  factory UsersState.initial() => const UsersState(
        promoters: [],
        failure: Failure(),
        status: UserStatus.initial,
        bussinessUsers: [],
      );

  @override
  List<Object> get props => [promoters, failure, status, bussinessUsers];

  UsersState copyWith({
    List<Promoter?>? promoters,
    Failure? failure,
    UserStatus? status,
    List<BussinessUser?>? bussinessUsers,
  }) {
    return UsersState(
      promoters: promoters ?? this.promoters,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      bussinessUsers: bussinessUsers ?? this.bussinessUsers,
    );
  }

  @override
  String toString() {
    return 'UsersState(promoters: $promoters, failure: $failure, status: $status, bussinessUser: $bussinessUsers)';
  }
}
