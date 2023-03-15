import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:image_search/data/data_source/result.dart';
import 'package:image_search/domain/model/photo.dart';
import 'package:image_search/domain/use_case/get_photos_use_case.dart';
import 'package:image_search/presentation/home/event/home_ui_event.dart';
import 'package:image_search/presentation/home/state/home_state.dart';

class HomeViewModel with ChangeNotifier {
  final GetPhotosUseCase getPhotosUseCase;

  HomeState _homeState = HomeState([], false);

  HomeState get homeState => _homeState;
  // List<Photo> _photos = [];
  // bool _isLoading = false;
  //
  // bool get isLoading => _isLoading;
  //
  // // 외부에서 photos 를 수정 못하게 하기위해
  // UnmodifiableListView<Photo> get photos => UnmodifiableListView(_photos);

  final _eventController = StreamController<HomeUiEvent>();

  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  HomeViewModel({
    required this.getPhotosUseCase,
  });

  Future<void> fetch(String val) async {
    _homeState = homeState.copyWith(isLoading: true);
    notifyListeners();

    final Result<List<Photo>> result = await getPhotosUseCase.call(val);

    result.when(
      success: (data) {
        _homeState = homeState.copyWith(photos: data);
        notifyListeners();
      },
      error: (e) {
        _eventController.add(HomeUiEvent.showSnackBar(e));
      },
    );
    _homeState = homeState.copyWith(isLoading: false);
    notifyListeners();
  }
}
