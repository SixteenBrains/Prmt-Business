part of 'preview_ad_cubit.dart';

enum PreviewAdStatus { initial, loading, succuss, error }

class PreviewAdState extends Equatable {
  final PreviewAdStatus status;
  final Failure failure;
  final AdModel? ad;

  const PreviewAdState({
    required this.status,
    required this.failure,
    required this.ad,
  });

  factory PreviewAdState.initial() => const PreviewAdState(
      status: PreviewAdStatus.initial, failure: Failure(), ad: null);

  @override
  List<Object?> get props => [status, failure, ad];

  PreviewAdState copyWith({
    PreviewAdStatus? status,
    Failure? failure,
    AdModel? ad,
  }) {
    return PreviewAdState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      ad: ad ?? this.ad,
    );
  }

  @override
  String toString() =>
      'PreviewAdState(status: $status, failure: $failure, ad: $ad)';
}
