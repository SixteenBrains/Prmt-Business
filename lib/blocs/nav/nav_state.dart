import 'package:equatable/equatable.dart';

import '/enums/enums.dart';

class NavState extends Equatable {
  final NavItem item;

  const NavState({
    required this.item,
  });

  factory NavState.initial() => const NavState(item: NavItem.dashboard);
  @override
  List<Object> get props => [item];

  @override
  String toString() => 'NavState(item: $item)';

  @override
  bool? get stringify => true;

  NavState copyWith({
    NavItem? item,
  }) {
    return NavState(
      item: item ?? this.item,
    );
  }
}
