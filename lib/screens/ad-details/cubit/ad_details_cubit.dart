import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_business/models/ad_model.dart';
import 'package:prmt_business/models/failure.dart';
import 'package:prmt_business/repositories/ad/ad_repository.dart';

part 'ad_details_state.dart';

class AdDetailsCubit extends Cubit<AdDetailsState> {
  final AdRepository _adRepository;
  AdDetailsCubit({required AdRepository adRepository})
      : _adRepository = adRepository,
        super(AdDetailsState.initial());

  void fetchAdDetailsFromId({required String? adId}) async {
    try {
      emit(state.copyWith(status: AdDetailsStatus.loading));
      final ad = await _adRepository.getAdDetails(adId: adId);
      emit(state.copyWith(ad: ad, status: AdDetailsStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(status: AdDetailsStatus.error, failure: failure));
    }
  }
}
