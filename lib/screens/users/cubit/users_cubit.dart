import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/models/bussiness_user.dart';
import '/models/failure.dart';
import '/models/promoter.dart';
import '/repositories/users/user_repository.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserRepository _userRepository;
  UsersCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UsersState.initial());

  void loadBussinessUsers() async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      final users = await _userRepository.getBussinessUsers();
      emit(state.copyWith(bussinessUsers: users, status: UserStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: UserStatus.error));
    }
  }

  void loadPromoters() async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      final users = await _userRepository.getPromoters();
      print('Promoters --- $users');
      emit(state.copyWith(promoters: users, status: UserStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: UserStatus.error));
    }
  }
}
