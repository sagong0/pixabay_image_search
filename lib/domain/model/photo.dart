// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'photo.g.dart';
//
// @JsonSerializable()
// class Photo extends Equatable{
//   final int id;
//   @JsonKey(name: 'previewURL')
//   final String previewUrl;
//   final String tags;
//
//   const Photo({
//     required this.id,
//     required this.previewUrl,
//     required this.tags,
//   });
//
//   factory Photo.fromJson(Map<String, dynamic> json)
//   => _$PhotoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PhotoToJson(this);
//
//   @override
//   // id 로 같은 것 기준 삼겠다!
//   List<Object?> get props => [id];
// }

import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo.freezed.dart';
part 'photo.g.dart';

@freezed
class Photo with _$Photo{
  factory Photo({
    required int id,
    required String tags,
    required String previewURL,
}) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json)
  => _$PhotoFromJson(json);
}
