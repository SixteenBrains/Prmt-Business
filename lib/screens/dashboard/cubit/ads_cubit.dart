import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/ad_model.dart';
import '/models/failure.dart';
import '/repositories/ad/ad_repository.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  final AdRepository _adRepository;
  final AuthBloc _authBloc;

  AdsCubit({
    required AdRepository adRepository,
    required AuthBloc authBloc,
  })  : _adRepository = adRepository,
        _authBloc = authBloc,
        super(AdsState.initial());

  void tabChanged(int index) {
    emit(state.copyWith(tabIndex: index));
    // loadDraftAds();
  }

  void loadLiveAds() async {
    try {
      emit(state.copyWith(status: AdStatus.loading));

      final ads = await _adRepository.getLiveAds(
          userId: _authBloc.state.user?.uid, showRecent: state.showRecent);

      emit(state.copyWith(
          ads: await Future.wait(ads), status: AdStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: AdStatus.error));
    }
  }

  void loadDraftAds() async {
    try {
      emit(state.copyWith(status: AdStatus.loading));

      final ads = await _adRepository.getUserDraftAds(
          userID: _authBloc.state.user?.uid);
      emit(state.copyWith(
          ads: await Future.wait(ads), status: AdStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(status: AdStatus.error, failure: failure));
    }
  }

  Future<int?> getUserTotalAds() async {
    final value =
        await _adRepository.getUserTotalAds(userId: _authBloc.state.user?.uid);
    return value;
  }

  void loadExpiredAds() async {
    try {
      emit(state.copyWith(status: AdStatus.loading));

      final ads =
          await _adRepository.getExpiredAds(userId: _authBloc.state.user?.uid);

      emit(state.copyWith(
          ads: await Future.wait(ads), status: AdStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: AdStatus.error));
    }
  }

  void toogleRecent() async {
    print('Normal ads - ${state.ads}');
    final List<AdModel> ads = List<AdModel>.from(state.ads.reversed.toList());
    emit(state.copyWith(ads: ads));
    // loadLiveAds();
  }
}
