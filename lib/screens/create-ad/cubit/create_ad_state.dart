part of 'create_ad_cubit.dart';

enum CreateAdStatus { initial, loading, submitting, succuss, error }
enum AdCurrentPage {
  adName,
  adType,
  adContent,
  adTargetLink,
  date,
  awesome,
  demographics,
  targetGroup,
}

// enum AdType { image, video, none }

class CreateAdState extends Equatable {
  final String adName;
  final MediaType mediaType;
  final String description;
  final CreateAdStatus status;
  final Failure failure;
  final AdCurrentPage currentPage;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? budget;
  final List<String> ageGroup;
  final List<String> incomeRange;
  final List<String> interests;
  final String state;
  final List<String> stateCities;
  final List<String> selectedCities;
  final String targetLink;
  final int progress;
  final File? adMedia;
  final Uint8List? videoThumbnail;

  const CreateAdState({
    required this.adName,
    required this.mediaType,
    required this.description,
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
    required this.stateCities,
    required this.targetLink,
    required this.progress,
    required this.adMedia,
    required this.selectedCities,
    this.videoThumbnail,
  });

  factory CreateAdState.initial() => const CreateAdState(
        adName: '',
        mediaType: MediaType.none,
        description: '',
        status: CreateAdStatus.initial,
        failure: Failure(),
        currentPage: AdCurrentPage.adName,
        startDate: null,
        endDate: null,
        budget: null,
        ageGroup: [],
        incomeRange: [],
        interests: [],
        state: 'Maharashtra',
        stateCities: [],
        targetLink: '',
        adMedia: null,
        progress: 0,
        videoThumbnail: null,
        selectedCities: [],
      );

  CreateAdState copyWith({
    String? adName,
    MediaType? mediaType,
    String? description,
    CreateAdStatus? status,
    Failure? failure,
    AdCurrentPage? currentPage,
    DateTime? startDate,
    DateTime? endDate,
    String? budget,
    List<String>? ageGroup,
    List<String>? incomeRange,
    List<String>? interests,
    String? state,
    List<String>? stateCities,
    String? targetLink,
    int? progress,
    File? adMedia,
    Uint8List? videoThumbnail,
    List<String>? selectedCities,
  }) {
    return CreateAdState(
      adName: adName ?? this.adName,
      mediaType: mediaType ?? this.mediaType,
      description: description ?? this.description,
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
      stateCities: stateCities ?? this.stateCities,
      targetLink: targetLink ?? this.targetLink,
      progress: progress ?? this.progress,
      adMedia: adMedia ?? this.adMedia,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      selectedCities: selectedCities ?? this.selectedCities,
    );
  }

  @override
  List<Object?> get props => [
        adName,
        mediaType,
        description,
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
        stateCities,
        targetLink,
        adMedia,
        progress,
        videoThumbnail,
        selectedCities,
      ];
}
