part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class ChangeTab extends DashboardEvent {
  final TabItem tabItem;

  const ChangeTab({required this.tabItem});

  @override
  List<Object> get props => [tabItem];

  @override
  String toString() => 'ChangeTab(tabItem: $tabItem)';
}
