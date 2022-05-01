part of 'dashboard_cubit.dart';

enum DashBoardStatus { initial, loading, succuss, error }

class DashboardState extends Equatable {
  final int? liveAds;
  final int? promotedAds;
  final int? expiredAds;
  final int? bussinessUsers;
  final int? promoters;
  final int? clickCount;
  final int? conversions;
  final int? withdrawal;
  final int? credit;
  final Failure? failure;
  final DashBoardStatus status;

  const DashboardState({
    this.liveAds,
    this.promotedAds,
    this.expiredAds,
    this.bussinessUsers,
    this.promoters,
    this.clickCount,
    this.conversions,
    this.withdrawal,
    this.credit,
    this.failure,
    required this.status,
  });

  factory DashboardState.initial() =>
      const DashboardState(status: DashBoardStatus.initial);

  @override
  List<Object?> get props {
    return [
      liveAds,
      promotedAds,
      expiredAds,
      bussinessUsers,
      promoters,
      clickCount,
      conversions,
      withdrawal,
      credit,
      status,
      failure
    ];
  }

  DashboardState copyWith({
    int? liveAds,
    int? promotedAds,
    int? expiredAds,
    int? bussinessUsers,
    int? promoters,
    int? clickCount,
    int? conversions,
    int? withdrawal,
    int? credit,
    Failure? failure,
    DashBoardStatus? status,
  }) {
    return DashboardState(
      liveAds: liveAds ?? this.liveAds,
      promotedAds: promotedAds ?? this.promotedAds,
      expiredAds: expiredAds ?? this.expiredAds,
      bussinessUsers: bussinessUsers ?? this.bussinessUsers,
      promoters: promoters ?? this.promoters,
      clickCount: clickCount ?? this.clickCount,
      conversions: conversions ?? this.conversions,
      withdrawal: withdrawal ?? this.withdrawal,
      credit: credit ?? this.credit,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'DashboardState(liveAds: $liveAds, promotedAds: $promotedAds, expiredAds: $expiredAds, bussinessUsers: $bussinessUsers, promoters: $promoters, clickCount: $clickCount, conversions: $conversions, withdrawal: $withdrawal, credit: $credit, failure: $failure, status: $status)';
  }
}
