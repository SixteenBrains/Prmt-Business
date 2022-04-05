import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_business/blocs/auth/auth_bloc.dart';
import 'package:prmt_business/models/appuser.dart';
import 'package:prmt_business/models/failure.dart';
import 'package:prmt_business/repositories/profile/profile_repo.dart';
import 'package:prmt_business/utils/media_util.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;
  final AuthBloc _authBloc;
  ProfileCubit({
    required AuthBloc authBloc,
    required ProfileRepository profileRepository,
  })  : _profileRepository = profileRepository,
        _authBloc = authBloc,
        super(ProfileState.initial());

  void loadProfile() async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      final user = await _profileRepository.getCurrentUserProfile(
          userId: _authBloc.state.user?.uid);
      emit(state.copyWith(status: ProfileStatus.succuss, user: user));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: ProfileStatus.error));
    }
  }

  void imagePicked(File image) async {
    try {
      emit(state.copyWith(imageFile: image));

      final user = state.user;
      if (user?.uid != null) {
        final imgUrl = await MediaUtil.uploadAdMedia(
            childName: 'profileImgs',
            file: image,
            uid: _authBloc.state.user!.uid!);

        await _profileRepository.editProfileImage(
            user: user?.copyWith(profileImg: imgUrl));

        emit(state.copyWith(status: ProfileStatus.imgUploaded));
      }
    } catch (error) {
      print('Error in img uploading');
    }
  }
}
