part of 'create_ad_cubit.dart';

enum CreateAdStatus { initial, loading, submitting, succuss, error }

enum CurrentPage {
  adName,
  adType,
  adContent,
  adTargetLink,
  date,
  awesome,
  demographics,
  previewAd,
  stateAndCity
}

enum AdType { image, video, none }

class CreateAdState extends Equatable {
  final Ad? adModel;
  final String adName;
  final AdType adType;
  final String adContentText;
  final CreateAdStatus status;
  final Failure failure;
  final CurrentPage currentPage;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? budget;
  final List<String> ageGroup;
  final List<String> incomeRange;
  final List<String> interests;
  final String state;
  final List<String> city;
  final String adTargetLink;
  final Uint8List? adImage;
  final File? adVideo;
  final Uint8List? adVideoThumbnail;

  const CreateAdState({
    required this.adModel,
    required this.adName,
    required this.adType,
    required this.adContentText,
    required this.status,
    required this.failure,
    required this.currentPage,
    required this.startDate,
    required this.endDate,
    required this.budget,
    required this.ageGroup,
    required this.incomeRange,
    required this.interests,
    required this.state,
    required this.city,
    required this.adTargetLink,
    required this.adImage,
    required this.adVideo,
    required this.adVideoThumbnail,
  });

  factory CreateAdState.initial() => const CreateAdState(
        adModel: null,
        adName: '',
        adType: AdType.none,
        adContentText: '',
        status: CreateAdStatus.initial,
        failure: Failure(),
        currentPage: CurrentPage.adName,
        startDate: null,
        endDate: null,
        budget: null,
        ageGroup: [],
        incomeRange: [],
        interests: [],
        state: '',
        city: [],
        adTargetLink: '',
        adImage: null,
        adVideo: null,
        adVideoThumbnail: null,
      );

  CreateAdState copyWith({
    Ad? adModel,
    String? adName,
    AdType? adType,
    String? adContentText,
    CreateAdStatus? status,
    Failure? failure,
    CurrentPage? currentPage,
    DateTime? startDate,
    DateTime? endDate,
    int? budget,
    List<String>? ageGroup,
    List<String>? incomeRange,
    List<String>? interests,
    String? state,
    List<String>? city,
    String? adTargetLink,
    Uint8List? adImage,
    File? adVideo,
    Uint8List? adVideoThumbnail,
  }) {
    return CreateAdState(
      adModel: adModel ?? this.adModel,
      adName: adName ?? this.adName,
      adType: adType ?? this.adType,
      adContentText: adContentText ?? this.adContentText,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      currentPage: currentPage ?? this.currentPage,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      budget: budget ?? this.budget,
      ageGroup: ageGroup ?? this.ageGroup,
      incomeRange: incomeRange ?? this.incomeRange,
      interests: interests ?? this.interests,
      state: state ?? this.state,
      city: city ?? this.city,
      adTargetLink: adTargetLink ?? this.adTargetLink,
      adImage: adImage ?? this.adImage,
      adVideo: adVideo ?? this.adVideo,
      adVideoThumbnail: adVideoThumbnail ?? this.adVideoThumbnail,
    );
  }

  @override
  List<Object?> get props => [
        adModel,
        adName,
        adType,
        adContentText,
        status,
        failure,
        currentPage,
        startDate,
        endDate,
        budget,
        ageGroup,
        incomeRange,
        interests,
        state,
        city,
        adTargetLink,
        adImage,
        adVideo,
        adVideoThumbnail,
      ];
}
