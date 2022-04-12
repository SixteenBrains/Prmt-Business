part of 'dashboard_bloc.dart';

enum TabItem { liveAds, drafsAds, expiredAds }

enum DashBoardStatus { initial, loading, succuss, error }

class DashBoardState extends Equatable {
  final TabItem tabItem;
  final Failure failure;
  final int? totalSpents;
  final int? noOfAds;
  final DashBoardStatus status;

  const DashBoardState({
    required this.tabItem,
    required this.failure,
    this.noOfAds,
    this.totalSpents,
    required this.status,
  });

  factory DashBoardState.initial() => const DashBoardState(
        tabItem: TabItem.liveAds,
        failure: Failure(),
        totalSpents: null,
        noOfAds: null,
        status: DashBoardStatus.initial,
      );

  @override
  List<Object?> get props => [tabItem, failure, totalSpents, noOfAds, status];

  DashBoardState copyWith({
    TabItem? tabItem,
    Failure? failure,
    int? totalSpents,
    int? noOfAds,
    DashBoardStatus? status,
  }) {
    return DashBoardState(
      tabItem: tabItem ?? this.tabItem,
      failure: failure ?? this.failure,
      totalSpents: totalSpents ?? this.totalSpents,
      noOfAds: noOfAds ?? this.noOfAds,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'DashBoardState(tabItem: $tabItem, failure: $failure, noOfAds: $noOfAds, totalSpents: $totalSpents, status: $status)';
}
