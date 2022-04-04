part of 'preview_ad_cubit.dart';

enum PreviewAdStatus { initial, loading, previewLoaded, succuss, error }

class PreviewAdState extends Equatable {
  final PreviewAdStatus status;
  final Failure failure;
  final AdModel? ad;
  final Uint8List? previewImage;

  const PreviewAdState({
    required this.status,
    required this.failure,
    required this.ad,
    required this.previewImage,
  });

  factory PreviewAdState.initial() => const PreviewAdState(
        status: PreviewAdStatus.initial,
        failure: Failure(),
        ad: null,
        previewImage: null,
      );

  @override
  List<Object?> get props => [status, failure, ad, previewImage];

  PreviewAdState copyWith({
    PreviewAdStatus? status,
    Failure? failure,
    AdModel? ad,
    Uint8List? previewImage,
  }) {
    return PreviewAdState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      ad: ad ?? this.ad,
      previewImage: previewImage ?? this.previewImage,
    );
  }

  @override
  String toString() =>
      'PreviewAdState(status: $status, failure: $failure, ad: $ad,previewImage: $previewImage)';
}
