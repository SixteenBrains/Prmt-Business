import 'package:equatable/equatable.dart';
import '/models/promoted_ad.dart';
import '/models/promoter.dart';

class AdData extends Equatable {
  final Promoter? promoter;
  final PromotedAd? promotedAd;

  const AdData({
    this.promoter,
    this.promotedAd,
  });

  AdData copyWith({
    Promoter? promoter,
    PromotedAd? promotedAd,
  }) {
    return AdData(
      promoter: promoter ?? this.promoter,
      promotedAd: promotedAd ?? this.promotedAd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'promoter': promoter?.toMap(),
      'promotedAd': promotedAd?.toMap(),
    };
  }

  // factory AdData.fromMap(Map<String, dynamic> map) {
  //   return AdData(
  //     promoter: map['promoter'] != null ? Promoter.fromMap(map['promoter']) : null,
  //     promotedAd: map['promotedAd'] != null ? PromotedAd.fromMap(map['promotedAd']) : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory AdData.fromJson(String source) => AdData.fromMap(json.decode(source));

  @override
  String toString() => 'AdData(promoter: $promoter, promotedAd: $promotedAd)';

  @override
  List<Object?> get props => [promoter, promotedAd];
}
