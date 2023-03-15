import 'package:image_search/data/data_source/pixabay_api.dart';
import 'package:image_search/data/repository/photo_api_repository_impl.dart';
import 'package:image_search/domain/respository/photo_api_repository.dart';
import 'package:image_search/domain/use_case/get_photos_use_case.dart';
import 'package:image_search/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:http/http.dart' as http;

// 1. Provider 전체 합치기
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

// 2. 독립적인 객체
List<SingleChildWidget> independentModels = [
  Provider<http.Client>(
    create: (context) => http.Client(),
  ),
];

// 3. 2번에 의존성 있는 객체
List<SingleChildWidget> dependentModels = [
  ProxyProvider<http.Client, PixaBayApi>(
    update: (context, client, value) => PixaBayApi(
      client: client,
    ),
  ),
  ProxyProvider<PixaBayApi, PhotoApiRepository>(
    update: (context, api, value) => PhotoApiRepositoryImpl(
      api: api,
    ),
  ),
  ProxyProvider<PhotoApiRepository, GetPhotosUseCase>(
    update: (context, repository, value) => GetPhotosUseCase(
      repository: repository,
    ),
  ),
];

// 4. viewModel
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider(
    create: (context) =>
        HomeViewModel(getPhotosUseCase: context.read<GetPhotosUseCase>()),
  ),
];
