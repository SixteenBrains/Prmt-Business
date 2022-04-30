part of 'users_cubit.dart';

enum UserStatus { initial, loading, succuss, error }

class UsersState extends Equatable {
  final List<Promoter?> promoters;
  final Failure failure;
  final UserStatus status;
  final List<BussinessUser?> bussinessUser;

  const UsersState({
    required this.promoters,
    required this.failure,
    required this.status,
    required this.bussinessUser,
  });

  factory UsersState.initial() => const UsersState(
        promoters: [],
        failure: Failure(),
        status: UserStatus.initial,
        bussinessUser: [],
      );

  @override
  List<Object> get props => [promoters, failure, status, bussinessUser];

  UsersState copyWith({
    List<Promoter?>? promoters,
    Failure? failure,
    UserStatus? status,
    List<BussinessUser?>? bussinessUser,
  }) {
    return UsersState(
      promoters: promoters ?? this.promoters,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      bussinessUser: bussinessUser ?? this.bussinessUser,
    );
  }

  @override
  String toString() {
    return 'UsersState(promoters: $promoters, failure: $failure, status: $status, bussinessUser: $bussinessUser)';
  }
}
