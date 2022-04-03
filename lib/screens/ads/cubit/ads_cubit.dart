import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/blocs/auth/auth_bloc.dart';
import '/models/ad_model.dart';
import '/models/failure.dart';
import '/repositories/ads/ads_repository.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  final AuthBloc _authBloc;
  final AdsRepository _adsRepository;
  AdsCubit({
    required AuthBloc authBloc,
    required AdsRepository adsRepository,
  })  : _authBloc = authBloc,
        _adsRepository = adsRepository,
        super(AdsState.initial());

  void loadAds() async {
    try {
      emit(state.copyWith(status: AdsStatus.loading));
      final ads = await _adsRepository.liveAds();
      emit(state.copyWith(
          ads: await Future.wait(ads), status: AdsStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: AdsStatus.error));
    }
  }
}
