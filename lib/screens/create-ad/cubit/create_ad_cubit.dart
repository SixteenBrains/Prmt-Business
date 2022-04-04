import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/repositories/ad/ad_repository.dart';
import '/enums/enums.dart';
import '/models/failure.dart';
part 'create_ad_state.dart';

class CreateAdCubit extends Cubit<CreateAdState> {
  final AdRepository _adRepository;
  CreateAdCubit({required AdRepository adRepository})
      : _adRepository = adRepository,
        super(CreateAdState.initial());

  void adNameChanged(String value) {
    emit(state.copyWith(
        adName: value, progress: 1, status: CreateAdStatus.initial));
  }

  void loadCites() async {
    emit(state.copyWith(status: CreateAdStatus.loading));
    final cities = await _adRepository.getStateCities(state: state.state);
    emit(state.copyWith(status: CreateAdStatus.initial, stateCities: cities));
  }

  void changePage(AdCurrentPage page) {
    emit(state.copyWith(currentPage: page, status: CreateAdStatus.initial));
  }

  void imagePicked(File pickedImage) async {
    emit(
      state.copyWith(
        //adImage: pickedImage,
        adMedia: pickedImage,
        progress: 2,
        mediaType: MediaType.image,
        status: CreateAdStatus.initial,
      ),
    );
  }

  void videoPicked(File pickedVideo, Uint8List? videoThumbnail) async {
    emit(
      state.copyWith(
        mediaType: MediaType.video,
        adMedia: pickedVideo,
        status: CreateAdStatus.initial,
        progress: 2,
        videoThumbnail: videoThumbnail,
      ),
    );
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(
        description: value, progress: 3, status: CreateAdStatus.initial));
  }

  void targetLinkChanged(String value) {
    emit(state.copyWith(
        targetLink: value, progress: 4, status: CreateAdStatus.initial));
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

  void addProgress(int value) async {
    emit(state.copyWith(progress: value));
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

    print('lenght of removed age group - ${ageGroupList.length}');

    //int progress = state.progress;

    //  print('lenght of removed age group progress - $progress');

    // if (ageGroupList.isEmpty) {
    //   progress--;
    // }

    // print('lenght of removed age group progress - $progress');

    emit(state.copyWith(
        ageGroup: ageGroupList,
        //  progress: progress,
        status: CreateAdStatus.initial));
  }

  void removeInterest(String value) {
    final List<String> interests = List.from(state.interests)..remove(value);
    // int progress = state.progress;

    // if (interests.isEmpty) {
    //   progress--;
    // }
    emit(state.copyWith(
        interests: interests,
        //progress: progress,
        status: CreateAdStatus.initial));
  }

  void removeIncomeRange(String value) {
    final List<String> incomeRange = List.from(state.incomeRange)
      ..remove(value);
    // int progress = state.progress;

    // if (incomeRange.isEmpty) {
    //   progress--;
    // }
    emit(state.copyWith(
        incomeRange: incomeRange,
        //progress: progress,
        status: CreateAdStatus.initial));
  }

  void stateChanged(String value) {
    emit(state.copyWith(
        state: value, progress: 11, status: CreateAdStatus.initial));
    loadCites();
  }

  void addCity(String value) {
    List<String> cities = List<String>.from(state.selectedCities)..add(value);
    emit(state.copyWith(
        selectedCities: cities, progress: 12, status: CreateAdStatus.initial));
  }

  void removeCity(String value) {
    List<String> cities = List<String>.from(state.selectedCities)
      ..remove(value);
    emit(
        state.copyWith(selectedCities: cities, status: CreateAdStatus.initial));
  }
}
