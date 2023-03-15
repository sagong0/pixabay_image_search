import 'dart:math';

import 'package:image_search/data/data_source/result.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/respository/photo_api_repository.dart';

class GetPhotosUseCase {
  final PhotoApiRepository repository;

  GetPhotosUseCase({
    required this.repository,
  });

  Future<Result<List<Photo>>> call(String val) async {
    final Result<List<Photo>> result = await repository.fetch(val);

    return result.when(
      success: (data) {
        return Result.success(
          data.sublist(
            0,
            min(3, data.length),
          ),
        );
      },
      error: (e) {
        return Result.error(e);
      },
    );
  }
}
