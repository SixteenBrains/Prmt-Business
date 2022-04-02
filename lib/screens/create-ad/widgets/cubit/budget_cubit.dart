import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_business/screens/create-ad/cubit/create_ad_cubit.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  final CreateAdCubit _createAdCubit;
  BudgetCubit({required CreateAdCubit createAdCubit})
      : _createAdCubit = createAdCubit,
        super(BudgetState.initial());

  void budgetChanged(String? value) {
    emit(state.copyWith(budget: value));
    _createAdCubit.budgetChanged(value);
  }

  void changeShowCustom(bool value) {
    emit(state.copyWith(showCustom: value));
  }
}
