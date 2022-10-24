import 'dart:async';

import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_imp.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and funtions that will be used through any view model
  final StreamController _inputStatestreamController =
      StreamController<FlowState>.broadcast();
  @override
  Sink get inputState => _inputStatestreamController.sink;
  @override
  Stream<FlowState> get outputState =>
      _inputStatestreamController.stream.map((event) => event);
  @override
  void dispose() {
    _inputStatestreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
