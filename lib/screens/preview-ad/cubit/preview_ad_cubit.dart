import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_business/enums/enums.dart';
import 'package:prmt_business/utils/media_util.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '/models/ad_model.dart';
import '/blocs/auth/auth_bloc.dart';
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

  void loadPreviewAd() async {
    emit(state.copyWith(status: PreviewAdStatus.loading));

    if (_ad?.adType == MediaType.video && _ad?.mediaFile != null) {
      final videoThumbnail = await VideoThumbnail.thumbnailData(
        video: _ad!.mediaFile!.path,
        imageFormat: ImageFormat.PNG,
        maxWidth:
            128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 25,
      );

      emit(state.copyWith(
          ad: _ad,
          previewImage: videoThumbnail,
          status: PreviewAdStatus.previewLoaded));
    } else if (_ad?.adType == MediaType.image) {
      emit(
        state.copyWith(
          ad: _ad,
          previewImage: await _ad?.mediaFile?.readAsBytes(),
          status: PreviewAdStatus.previewLoaded,
        ),
      );
    } else {
      emit(state.copyWith(status: PreviewAdStatus.previewLoaded));
    }
  }

  void draftAd() async {
    try {
      emit(state.copyWith(status: PreviewAdStatus.loading));

      String? mediaUrl;
      if (_authBloc.state.user?.uid != null && _ad?.mediaFile != null) {
        mediaUrl = await MediaUtil.uploadAdMedia(
          childName: 'media',
          file: _ad!.mediaFile!,
          uid: _authBloc.state.user!.uid!,
        );
      }

      await _adRepository.dratAd(
          ad: _ad?.copyWith(mediaUrl: mediaUrl),
          userId: _authBloc.state.user?.uid);

      emit(state.copyWith(status: PreviewAdStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(status: PreviewAdStatus.error, failure: failure));
    }
  }
}
