import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/ad_model.dart';
import '/models/failure.dart';
import '/repositories/ad/ad_repository.dart';

part 'preview_ad_state.dart';

class PreviewAdCubit extends Cubit<PreviewAdState> {
  final AuthBloc _authBloc;
  final AdModel? _ad;
  final AdRepository _adRepository;

  PreviewAdCubit({
    required AuthBloc authBloc,
    required AdRepository adRepository,
    required AdModel? adModel,
  })  : _authBloc = authBloc,
        _ad = adModel,
        _adRepository = adRepository,
        super(PreviewAdState.initial());

  void loadPreviewAd() {
    emit(state.copyWith(ad: _ad, status: PreviewAdStatus.initial));
  }

  void draftAd() async {
    try {
      emit(state.copyWith(status: PreviewAdStatus.loading));

      await _adRepository.dratAd(ad: _ad, userId: _authBloc.state.user?.uid);

      emit(state.copyWith(status: PreviewAdStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(status: PreviewAdStatus.error, failure: failure));
    }
  }
}
