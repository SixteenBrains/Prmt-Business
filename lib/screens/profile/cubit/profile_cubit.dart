import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prmt_business/blocs/auth/auth_bloc.dart';
import 'package:prmt_business/models/appuser.dart';
import 'package:prmt_business/models/failure.dart';
import 'package:prmt_business/repositories/profile/profile_repository.dart';
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

        emit(state.copyWith(
            status: ProfileStatus.imgUploaded,
            user: user?.copyWith(profileImg: imgUrl)));
        _authBloc.add(UserProfileImageChanged(imgUrl: imgUrl));
      }
    } catch (error) {
      print('Error in img uploading');
    }
  }

  void nameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void stateNameChaned(String value) {
    emit(state.copyWith(stateName: value));
  }

  void cityNameChanged(String value) {
    emit(state.copyWith(cityName: value));
  }

  void editProfile() async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      final user = state.user;
      await _profileRepository.editProfile(
        user: user?.copyWith(
          name: state.name,
          state: state.stateName,
          city: state.cityName,
        ),
      );
      emit(state.copyWith(status: ProfileStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: ProfileStatus.error));
    }
  }
}
