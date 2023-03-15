import 'package:image_search/data/data_source/pixabay_api.dart';
import 'package:image_search/data/data_source/result.dart';
import 'package:image_search/domain/respository/photo_api_repository.dart';
import 'package:http/http.dart' as http;
import 'package:image_search/domain/model/photo.dart';

class PhotoApiRepositoryImpl implements PhotoApiRepository {
  PixaBayApi api;

  PhotoApiRepositoryImpl({
    required this.api,
  });

  Future<Result<List<Photo>>> fetch(String val) async {
    final Result<List> result = await api.fetch(val);

    return result.when(
      success: (data) {
        return Result.success(data.map((e) => Photo.fromJson(e)).toList());
      },
      error: (e) {
        return Result.error(e);
      },
    );
  }
}
