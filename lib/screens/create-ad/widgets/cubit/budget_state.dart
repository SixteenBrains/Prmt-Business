part of 'budget_cubit.dart';

class BudgetState extends Equatable {
  final bool showCustom;
  final String budget;

  const BudgetState({
    required this.showCustom,
    required this.budget,
  });

  @override
  List<Object> get props => [showCustom, budget];

  factory BudgetState.initial() =>
      const BudgetState(showCustom: false, budget: '');

  BudgetState copyWith({
    bool? showCustom,
    String? budget,
  }) {
    return BudgetState(
      showCustom: showCustom ?? this.showCustom,
      budget: budget ?? this.budget,
    );
  }
}
