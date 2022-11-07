import 'dart:async';
import 'dart:ffi';

import 'package:mvvm_demo/domain/model/model.dart';
import 'package:mvvm_demo/domain/usecase/home_usecase.dart';
import 'package:mvvm_demo/presentation/base/base_viewmodel.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:rxdart/subjects.dart';

class HomeViewmodel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUsecase _homeUsecase;
  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  HomeViewmodel(this._homeUsecase);

  // inputs
  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    // ignore: void_checks
    (await _homeUsecase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputHomeData.add(HomeViewObject(homeObject.data.stores,
          homeObject.data.services, homeObject.data.banners));
      inputState.add(ContentState());
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // outputs
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAD> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
