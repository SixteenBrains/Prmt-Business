part of 'ads_cubit.dart';

enum AdsStatus { inital, loading, succuss, error }

class AdsState extends Equatable {
  final Failure failure;
  final List<AdModel?> ads;
  final AdsStatus status;
  final List<AdData?> adData;

  const AdsState({
    required this.failure,
    required this.ads,
    required this.status,
    required this.adData,
  });

  factory AdsState.initial() => const AdsState(
      failure: Failure(), ads: [], status: AdsStatus.inital, adData: []);

  @override
  List<Object> get props => [
        failure,
        ads,
        status,
        adData,
      ];

  AdsState copyWith({
    Failure? failure,
    List<AdModel?>? ads,
    AdsStatus? status,
    List<AdData?>? adData,
  }) {
    return AdsState(
      failure: failure ?? this.failure,
      ads: ads ?? this.ads,
      status: status ?? this.status,
      adData: adData ?? this.adData,
    );
  }

  @override
  String toString() =>
      'AdsState(failure: $failure, ads: $ads, status: $status, promoters: $adData)';
}
