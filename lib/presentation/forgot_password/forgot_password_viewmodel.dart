import 'dart:async';

import 'package:mvvm_demo/app/funtions.dart';
import 'package:mvvm_demo/domain/usecase/forgot_password_usecase.dart';
import 'package:mvvm_demo/presentation/base/base_viewmodel.dart';
import 'package:mvvm_demo/presentation/common/freezed_data_classes.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_imp.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  var forgotPasswordObject = ForgotPasswordObject("");

  final ForgotPasswordUsecase _forgotPasswordUsecase;

  ForgotPasswordViewModel(this._forgotPasswordUsecase);

  final StreamController _isAllInputValidController =
      StreamController<void>.broadcast();

  bool onProcessing = false;

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidController.close();
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgotPasswordUsecase.execute(forgotPasswordObject.email)).fold(
        (failure) => {
              inputState.add(ErrorState(
                  StateRendererType.POPUP_ERROR_STATE, failure.message))
            },
        (data) => {
              onProcessing = true,
              inputValid.add(null),
              inputState.add(
                  SuccessState(StateRendererType.POPUP_SUCCESS_STATE, data)),
            });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputValid => _isAllInputValidController.sink;

  @override
  Stream<String?> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => validateEmail(email));
  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidController.stream.map((event) => _isAllInputValid());

  @override
  setEmail(String email) {
    inputEmail.add(email);
    forgotPasswordObject = forgotPasswordObject.copyWith(email: email);
    inputValid.add(null);
    onProcessing = false;
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  bool _isAllInputValid() {
    if (validateEmail(forgotPasswordObject.email) == null && !onProcessing) {
      return true;
    } else {
      return false;
    }
  }
}

abstract class ForgetPasswordViewModelInputs {
  // three funtionc
  setEmail(String email);
  forgotPassword();
  //two sink
  Sink get inputEmail;
  Sink get inputValid;
}

abstract class ForgetPasswordViewModelOutputs {
  Stream<String?> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}
