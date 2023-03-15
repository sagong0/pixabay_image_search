import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_search/domain/model/photo.dart';

part 'home_state.freezed.dart';
part 'home_state.g.dart';

// class HomeState {
//   final List<Photo> photos;
//   final bool isLoading;
//
//   HomeState({
//     required this.photos,
//     required this.isLoading,
//   });
//
//   HomeState copyWith({
//     List<Photo>? photos,
//     bool? isLoading,
//   }) {
//     return HomeState(
//       photos: photos ?? this.photos,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
// }

@freezed
class HomeState with _$HomeState{
  factory HomeState(
      List<Photo> photos,
      bool isLoading,
      ) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json)
  => _$HomeStateFromJson(json);
}