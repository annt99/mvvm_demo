// ignore_for_file: avoid_print

import 'dart:async';

import 'package:mvvm_demo/domain/usecase/login_usecase.dart';
import 'package:mvvm_demo/presentation/base/base_viewmodel.dart';
import 'package:mvvm_demo/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputValidController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase; //todo: remove ?

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    inputIsAllInput.close();
  }

  @override
  void start() {}

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _usernameStreamController.sink;

  @override
  Sink get inputIsAllInput => _isAllInputValidController.sink;

  @override
  login() async {
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold(
            (failure) => {
                  print(failure.message)
                  //failure
                },
            (data) => {
                  print(data.customer?.name)
                  //success
                });
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));
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

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUsernameValid(loginObject.username);
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
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputValid;
}
