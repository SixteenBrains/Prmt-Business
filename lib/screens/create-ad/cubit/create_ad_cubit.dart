import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/models/ad.dart';
import '/models/failure.dart';
part 'create_ad_state.dart';

class CreateAdCubit extends Cubit<CreateAdState> {
  CreateAdCubit() : super(CreateAdState.initial());

  void adNameChanged(String value) {
    emit(state.copyWith(
        adName: value, progress: 1, status: CreateAdStatus.initial));
  }

  void changePage(AdCurrentPage page) {
    emit(state.copyWith(currentPage: page, status: CreateAdStatus.initial));
  }

  void imagePicked(Uint8List pickedImage) async {
    emit(state.copyWith(
        adImage: pickedImage, progress: 2, status: CreateAdStatus.initial));
  }

  void videoPicked(File pickedVideo, Uint8List? thumbnail) async {
    emit(
      state.copyWith(
        adVideo: pickedVideo,
        adVideoThumbnail: thumbnail,
        status: CreateAdStatus.initial,
        progress: 2,
      ),
    );
  }

  void contentTextChanged(String value) {
    emit(state.copyWith(
        adContentText: value, progress: 3, status: CreateAdStatus.initial));
  }

  void targetLinkChanged(String value) {
    emit(state.copyWith(
        adTargetLink: value, progress: 4, status: CreateAdStatus.initial));
  }

  void startDateChanged(DateTime pickedDate) {
    emit(state.copyWith(
        startDate: pickedDate, progress: 5, status: CreateAdStatus.initial));
  }

  void endDateChanged(DateTime pickedDate) {
    emit(state.copyWith(
        endDate: pickedDate, progress: 6, status: CreateAdStatus.initial));
  }

  void budgetChanged(String? value) {
    emit(state.copyWith(
        budget: value, progress: 7, status: CreateAdStatus.initial));
  }

  void addAgeGroup(String value) {
    final List<String> ageGroupList = List.from(state.ageGroup)..add(value);
    emit(state.copyWith(
        ageGroup: ageGroupList, progress: 8, status: CreateAdStatus.initial));
  }

  void addInterest(String value) {
    final List<String> interests = List.from(state.interests)..add(value);
    emit(state.copyWith(
        interests: interests, progress: 10, status: CreateAdStatus.initial));
  }

  void addIncomeRange(String value) {
    final List<String> incomeRange = List.from(state.incomeRange)..add(value);
    emit(state.copyWith(
        incomeRange: incomeRange, progress: 9, status: CreateAdStatus.initial));
  }

  void removeAgeGroup(String value) {
    final List<String> ageGroupList = List.from(state.ageGroup)..remove(value);

    int progress = state.progress;

    if (ageGroupList.isNotEmpty) {
      progress--;
    }

    emit(state.copyWith(
        ageGroup: ageGroupList,
        progress: progress,
        status: CreateAdStatus.initial));
  }

  void removeInterest(String value) {
    final List<String> interests = List.from(state.interests)..remove(value);
    int progress = state.progress;

    if (interests.isNotEmpty) {
      progress--;
    }
    emit(state.copyWith(
        interests: interests,
        progress: progress,
        status: CreateAdStatus.initial));
  }

  void removeIncomeRange(String value) {
    final List<String> incomeRange = List.from(state.incomeRange)
      ..remove(value);
    int progress = state.progress;

    if (incomeRange.isNotEmpty) {
      progress--;
    }
    emit(state.copyWith(
        incomeRange: incomeRange,
        progress: progress,
        status: CreateAdStatus.initial));
  }

  void stateChanged(String value) {
    emit(state.copyWith(
        state: value, progress: 11, status: CreateAdStatus.initial));
  }

  void cityChanged(String value) {
    emit(state.copyWith(
        city: value, progress: 12, status: CreateAdStatus.initial));
  }
}
