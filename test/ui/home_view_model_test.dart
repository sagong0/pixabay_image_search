import 'package:flutter_test/flutter_test.dart';
import 'package:image_search/data/data_source/result.dart';
import 'package:image_search/domain/respository/photo_api_repository.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/use_case/get_photos_use_case.dart';
import 'package:image_search/presentation/home/home_view_model.dart';

void main() {
  test("Stream이 잘동착해야한다...", () async {
    final viewModel = HomeViewModel(
      getPhotosUseCase: GetPhotosUseCase(
        repository: FakePhotoApiRepository(),
      ),
    );

    await viewModel.fetch('apple');

    final result = fakeJson.map((e) => Photo.fromJson(e)).toList();

    expect(viewModel.homeState.photos, result);
  });
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<Result<List<Photo>>> fetch(String val) async {
    Future.delayed(const Duration(milliseconds: 500));

    return Result.success(fakeJson.map((e) => Photo.fromJson(e)).toList());
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 634572,
    "pageURL":
        "https://pixabay.com/photos/apples-fruits-red-ripe-vitamins-634572/",
    "type": "photo",
    "tags": "apples, fruits, red",
    "previewURL":
        "https://cdn.pixabay.com/photo/2015/02/13/00/43/apples-634572_150.jpg",
    "previewWidth": 100,
    "previewHeight": 150,
    "webformatURL":
        "https://pixabay.com/get/gc09049edd94b4ba15aa9c0337caf7220160710ac0cffe16b59c57526cc8bea850d291c1fa0fd81373b1135b7d79f9b77_640.jpg",
    "webformatWidth": 427,
    "webformatHeight": 640,
    "largeImageURL":
        "https://pixabay.com/get/g176db41d140c2d8b3533a032d93d97a7100ab8433ce7e1b1f7066a9d0c7204f14dc1c476affc9244307cca4addef60b6584d10bbead053466128b60ae852f16d_1280.jpg",
    "imageWidth": 3345,
    "imageHeight": 5017,
    "imageSize": 811238,
    "views": 474537,
    "downloads": 277318,
    "collections": 1268,
    "likes": 2352,
    "comments": 194,
    "user_id": 752536,
    "user": "Desertrose7",
    "userImageURL":
        "https://cdn.pixabay.com/user/2016/03/14/13-25-18-933_250x250.jpg"
  },
  {
    "id": 1868496,
    "pageURL":
        "https://pixabay.com/photos/apple-computer-desk-workspace-1868496/",
    "type": "photo",
    "tags": "apple, computer, desk",
    "previewURL":
        "https://cdn.pixabay.com/photo/2016/11/29/08/41/apple-1868496_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g9a2b22a7641b54e7c0e4e3c41071289fdacff7f2004b2fc8cf4ea9b1a503545b15cfd56da5025a9f91bc369b943a4869c0c08aba87fa6701cdbd7331d2c04842_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g5b3020789ad67be508c9b336a8e3b888bd4e6a449193f5ad95916649b8a4d683b99df2470fbc366759cf9daf5f0dc330398f1d43c7dd43bab297bb4b09aa4c2a_1280.jpg",
    "imageWidth": 5184,
    "imageHeight": 3456,
    "imageSize": 2735519,
    "views": 678340,
    "downloads": 492945,
    "collections": 1374,
    "likes": 1028,
    "comments": 274,
    "user_id": 2286921,
    "user": "Pexels",
    "userImageURL":
        "https://cdn.pixabay.com/user/2016/03/26/22-06-36-459_250x250.jpg"
  },
];
