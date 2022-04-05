import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/screens/dashboard/cubit/ads_cubit.dart';
import '/models/failure.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashBoardState> {
  final AdsCubit _adsCubit;
  DashboardBloc({required AdsCubit adsCubit})
      : _adsCubit = adsCubit,
        super(DashBoardState.initial()) {
    _adsCubit.loadLiveAds();
    on<DashboardEvent>((event, emit) {
      if (event is ChangeTab) {
        emit(state.copyWith(tabItem: event.tabItem));
      }
    });
  }
}
