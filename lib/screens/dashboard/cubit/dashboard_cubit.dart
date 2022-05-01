import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/models/failure.dart';
import '/repositories/stats/stats_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final StatsRepository _statsRepository;
  DashboardCubit({required StatsRepository statsRepository})
      : _statsRepository = statsRepository,
        super(DashboardState.initial());

  void loadAdCount() async {
    try {
      emit(state.copyWith(status: DashBoardStatus.loading));
      final adCount = await _statsRepository.getAdsCount();
      emit(
        state.copyWith(
          status: DashBoardStatus.succuss,
          liveAds: adCount?.liveAdCount,
          expiredAds: adCount?.expiredAdCount,
          promotedAds: adCount?.promotedAdCount,
        ),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: DashBoardStatus.error));
    }
  }

  void loadUsersCount() async {
    try {
      emit(state.copyWith(status: DashBoardStatus.loading));
      final bussinessCount = await _statsRepository.getBussinessUsersCount();
      final promoterCount = await _statsRepository.getPromotersCount();
      emit(
        state.copyWith(
          bussinessUsers: bussinessCount,
          promoters: promoterCount,
          status: DashBoardStatus.succuss,
        ),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: DashBoardStatus.error));
    }
  }
}
