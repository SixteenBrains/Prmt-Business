part of 'ad_details_cubit.dart';

enum AdDetailsStatus { initial, loading, succuss, error }

class AdDetailsState extends Equatable {
  final AdModel? ad;
  final Failure failure;
  final AdDetailsStatus status;

  const AdDetailsState({
    this.ad,
    required this.failure,
    required this.status,
  });

  factory AdDetailsState.initial() => const AdDetailsState(
        failure: Failure(),
        status: AdDetailsStatus.initial,
        ad: null,
      );

  @override
  List<Object?> get props => [ad, failure, status];

  AdDetailsState copyWith({
    AdModel? ad,
    Failure? failure,
    AdDetailsStatus? status,
  }) {
    return AdDetailsState(
      ad: ad ?? this.ad,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'AdDetailsState(ad: $ad, failure: $failure, status: $status)';
}
