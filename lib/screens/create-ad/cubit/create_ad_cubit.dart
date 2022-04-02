import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/ad.dart';
import '/models/failure.dart';
part 'create_ad_state.dart';

class CreateAdCubit extends Cubit<CreateAdState> {
  CreateAdCubit() : super(CreateAdState.initial());

  void adNameChanged(String value) {
    emit(state.copyWith(adName: value, status: CreateAdStatus.initial));
  }

  void changePage(CurrentPage page) {
    emit(state.copyWith(currentPage: page, status: CreateAdStatus.initial));
  }

  void imagePicked(Uint8List pickedImage) async {
    emit(state.copyWith(adImage: pickedImage, status: CreateAdStatus.initial));
  }

  void videoPicked(File pickedVideo, Uint8List? thumbnail) async {
    emit(state.copyWith(
        adVideo: pickedVideo,
        adVideoThumbnail: thumbnail,
        status: CreateAdStatus.initial));
  }

  void contentTextChanged(String value) {
    emit(state.copyWith(adContentText: value, status: CreateAdStatus.initial));
  }

  void targetLinkChanged(String value) {
    emit(state.copyWith(adTargetLink: value, status: CreateAdStatus.initial));
  }

  void startDateChanged(DateTime pickedDate) {
    emit(state.copyWith(startDate: pickedDate, status: CreateAdStatus.initial));
  }

  void endDateChanged(DateTime pickedDate) {
    emit(state.copyWith(endDate: pickedDate, status: CreateAdStatus.initial));
  }

  void budgetChanged(int value) {
    emit(state.copyWith(budget: value, status: CreateAdStatus.initial));
  }

  void ageGroupChanged(List<String> value) {
    emit(state.copyWith(ageGroup: value, status: CreateAdStatus.initial));
  }

  void interestsChanged(List<String> value) {
    emit(state.copyWith(ageGroup: value, status: CreateAdStatus.initial));
  }

  void incomeRangeChanged(List<String> value) {
    emit(state.copyWith(incomeRange: value, status: CreateAdStatus.initial));
  }

  void stateChanged(String value) {
    emit(state.copyWith(state: value, status: CreateAdStatus.initial));
  }

  void cityChanged(List<String> value) {
    emit(state.copyWith(city: value, status: CreateAdStatus.initial));
  }
}
