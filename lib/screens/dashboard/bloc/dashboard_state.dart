part of 'dashboard_bloc.dart';

enum TabItem { liveAds, drafsAds, expiredAds }

class DashBoardState extends Equatable {
  final TabItem tabItem;
  final Failure failure;

  const DashBoardState({
    required this.tabItem,
    required this.failure,
  });

  factory DashBoardState.initial() =>
      const DashBoardState(tabItem: TabItem.liveAds, failure: Failure());

  @override
  List<Object> get props => [tabItem, failure];

  DashBoardState copyWith({
    TabItem? tabItem,
    Failure? failure,
  }) {
    return DashBoardState(
      tabItem: tabItem ?? this.tabItem,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() => 'DashBoardState(tabItem: $tabItem, failure: $failure)';
}
