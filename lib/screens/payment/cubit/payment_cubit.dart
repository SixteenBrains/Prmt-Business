import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/enums/enums.dart';
import '/models/ad_model.dart';
import '/utils/media_util.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/failure.dart';
import '/repositories/ad/ad_repository.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final AdRepository _adRepository;
  final AuthBloc _authBloc;
  final AdModel? _ad;

  PaymentCubit(
      {required AdRepository adRepository,
      required AuthBloc authBloc,
      required AdModel? ad})
      : _adRepository = adRepository,
        _authBloc = authBloc,
        _ad = ad,
        super(PaymentState.initial());

  void publishAd() async {
    try {
      emit(state.copyWith(status: PaymentStatus.loading));

      String? mediaUrl;
      if (_authBloc.state.user?.uid != null && _ad?.mediaFile != null) {
        mediaUrl = await MediaUtil.uploadAdMedia(
          childName: _ad?.adType == MediaType.image ? 'images' : 'videos',
          file: _ad!.mediaFile!,
          uid: _authBloc.state.user!.uid!,
        );
      }

      await _adRepository.publishAd(
          ad: _ad?.copyWith(mediaUrl: mediaUrl),
          userId: _authBloc.state.user?.uid);

      emit(state.copyWith(status: PaymentStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(status: PaymentStatus.error, failure: failure));
    }
  }
}
