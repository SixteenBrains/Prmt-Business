part of 'ads_cubit.dart';

enum AdStatus { initial, loading, succuss, error }

class AdsState extends Equatable {
  final List<AdModel?> ads;
  final AdStatus status;
  final Failure failure;
  final int tabIndex;
  final bool showRecent;

  const AdsState({
    required this.ads,
    required this.status,
    required this.failure,
    this.showRecent = true,
    this.tabIndex = 0,
  });

  factory AdsState.initial() => const AdsState(
        ads: [],
        status: AdStatus.initial,
        failure: Failure(),
        tabIndex: 0,
        showRecent: true,
      );

  @override
  List<Object> get props => [ads, status, failure, tabIndex, showRecent];

  AdsState copyWith({
    List<AdModel?>? ads,
    AdStatus? status,
    Failure? failure,
    int? tabIndex,
    bool? showRecent,
  }) {
    return AdsState(
      ads: ads ?? this.ads,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      tabIndex: tabIndex ?? this.tabIndex,
      showRecent: showRecent ?? this.showRecent,
    );
  }

  @override
  String toString() =>
      'AdState(liveAds: $ads, status: $status, failure: $failure tabIndex: &tabIndex,showRecent: $showRecent )';
}
