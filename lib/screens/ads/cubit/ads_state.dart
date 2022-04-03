part of 'ads_cubit.dart';

enum AdsStatus { inital, loading, succuss, error }

class AdsState extends Equatable {
  final Failure failure;
  final List<AdModel?> ads;
  final AdsStatus status;

  const AdsState({
    required this.failure,
    required this.ads,
    required this.status,
  });

  factory AdsState.initial() =>
      const AdsState(failure: Failure(), ads: [], status: AdsStatus.inital);

  @override
  List<Object> get props => [failure, ads, status];

  AdsState copyWith({
    Failure? failure,
    List<AdModel?>? ads,
    AdsStatus? status,
  }) {
    return AdsState(
      failure: failure ?? this.failure,
      ads: ads ?? this.ads,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'AdsState(failure: $failure, ads: $ads, status: $status)';
}
