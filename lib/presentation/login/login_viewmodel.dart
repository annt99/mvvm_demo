// ignore_for_file: avoid_print

import 'dart:async';

import 'package:mvvm_demo/domain/usecase/login_usecase.dart';
import 'package:mvvm_demo/presentation/base/base_viewmodel.dart';
import 'package:mvvm_demo/presentation/common/freezed_data_classes.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_imp.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputValidController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    inputIsAllInput.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _usernameStreamController.sink;

  @override
  Sink get inputIsAllInput => _isAllInputValidController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                  //failure
                },
            (data) => {
                  inputState.add(ContentState())
                  //success
                });
  }

  @override
  Stream<String?> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => validatePassword(password));

  @override
  Stream<String?> get outputIsUsernameValid => _usernameStreamController.stream
      .map((username) => validateEmail(username));
  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidController.stream.map((event) => _isAllInputValid());

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    loginObject = loginObject.copyWith(username: username);
    _validate();
  }

  _validate() {
    inputIsAllInput.add(null);
  }

  String? validateEmail(String value) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return 'Please enter Email';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Email is valid';
      } else {
        return null;
      }
    }
  }

  String? validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Password must contain [A-Z][a-z][0-9]';
      } else {
        return null;
      }
    }
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUsernameValid(loginObject.username) &&
        validateEmail(loginObject.username) == null &&
        validatePassword(loginObject.password) == null;
  }
}

abstract class LoginViewModelInputs {
  // three funtionc
  setUserName(String username);
  setPassword(String password);
  login();
  //two sink
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInput;
}

abstract class LoginViewModelOutputs {
  Stream<String?> get outputIsUsernameValid;
  Stream<String?> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputValid;
}
