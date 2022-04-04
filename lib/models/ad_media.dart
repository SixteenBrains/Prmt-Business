// import 'dart:convert';

// import 'package:enum_to_string/enum_to_string.dart';
// import 'package:equatable/equatable.dart';

// import '/screens/create-ad/cubit/create_ad_cubit.dart';

// class AdMedia extends Equatable {
//   final String? mediaUrl;
//   final AdType? type;

//   const AdMedia({
//     this.mediaUrl,
//     required this.type,
//   });

//   AdMedia copyWith({
//     String? mediaUrl,
//     AdType? type,
//   }) {
//     return AdMedia(
//       mediaUrl: mediaUrl ?? this.mediaUrl,
//       type: type ?? this.type,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'mediaUrl': mediaUrl,
//       'type': EnumToString.convertToString(type),
//     };
//   }

//   factory AdMedia.fromMap(Map<String, dynamic> map) {
//     return AdMedia(
//       mediaUrl: map['mediaUrl'],
//       type: map['type'] != null
//           ? EnumToString.fromString(AdType.values, map['type'])
//           : AdType.none,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AdMedia.fromJson(String source) =>
//       AdMedia.fromMap(json.decode(source));

//   @override
//   String toString() => 'AdMedia(mediaUrl: $mediaUrl, type: $type)';

//   @override
//   List<Object?> get props => [mediaUrl, type];
// }
