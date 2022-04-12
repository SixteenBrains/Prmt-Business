import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/payment/payment_repository.dart';
import '/screens/dashboard/cubit/ads_cubit.dart';
import '/models/failure.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashBoardState> {
  final AdsCubit _adsCubit;
  final PaymentRepository _paymentRepository;
  final AuthBloc _authBloc;

  DashboardBloc({
    required AdsCubit adsCubit,
    required AuthBloc authBloc,
    required PaymentRepository paymentRepository,
  })  : _adsCubit = adsCubit,
        _paymentRepository = paymentRepository,
        _authBloc = authBloc,
        super(DashBoardState.initial()) {
    _adsCubit.loadLiveAds();
    on<LoadDashBoard>((event, emit) async {
      emit(state.copyWith(status: DashBoardStatus.loading));
      final totalAds = await _adsCubit.getUserTotalAds();
      int spents = 0;
      final payments = await _paymentRepository.getUserPaymentDetails(
          userId: _authBloc.state.user?.uid);

      for (var element in payments) {
        if (element?.amount != null) {
          spents += element!.amount!;
        }
      }

      emit(state.copyWith(
        totalSpents: spents,
        noOfAds: totalAds,
        status: DashBoardStatus.succuss,
      ));
    });

    on<ChangeTab>(
        (event, emit) => emit(state.copyWith(tabItem: event.tabItem)));
  }
}
