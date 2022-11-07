import 'dart:async';

import 'package:mvvm_demo/app/funtions.dart';
import 'package:mvvm_demo/core/utils/string_manager.dart';
import 'package:mvvm_demo/domain/usecase/register_usecase.dart';
import 'package:mvvm_demo/presentation/base/base_viewmodel.dart';
import 'package:mvvm_demo/presentation/common/freezed_data_classes.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_imp.dart';

abstract class RegisterViewModelInputs {
  //function
  setName(String name);
  setNumberCountryCode(String numberCountryCode);
  setEmail(String email);
  setPassword(String password);
  setPhoneNumber(String numberPhone);
  setProfilePicture(String picture);
  register();
  // sink
  Sink get inputName;
  Sink get inputEmail;
  Sink get inputPassword;
  // Sink get inputCountryCode;
  Sink get inputPhoneNumber;
  Sink get inputPicture;
  Sink get inputIsAll;
}

abstract class RegisterViewModelOutputs {
  Stream<String?> get outputIsNameValid;
  Stream<String?> get outputIsEmailValid;
  Stream<String?> get outputIsPasswordValid;
  Stream<String?> get outputIsPhoneNumberValid;
  Stream<String?> get outputIsProfilePictureValid;
  Stream<bool> get outputIsAllInputValid;
}

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final _nameStreamController = StreamController<String>.broadcast();
  final _emailStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();
  final _numberPhoneStreamController = StreamController<String>.broadcast();
  final _profilePictureStreamController = StreamController<String>.broadcast();
  final _isAllValueStreamController = StreamController<void>.broadcast();
  final RegisterUsecase _registerUsecase;
  final StreamController isRegisterSuccessStreamController =
      StreamController<bool>();
  RegisterViewModel(this._registerUsecase);
  var registerObject = RegisterObject("", "", "", "", "", "");

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAll => _isAllValueStreamController.sink;

  @override
  Sink get inputName => _nameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputPhoneNumber => _numberPhoneStreamController.sink;

  @override
  Sink get inputPicture => _profilePictureStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllValueStreamController.stream.map((event) => _isAllValueValid());

  @override
  Stream<String?> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => validateEmail(email));

  @override
  Stream<String?> get outputIsNameValid =>
      _nameStreamController.stream.map((name) => _validName(name));

  @override
  Stream<String?> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => validatePassword(password));

  @override
  Stream<String?> get outputIsPhoneNumberValid =>
      _numberPhoneStreamController.stream
          .map((phoneNumber) => _validNumberPhone(phoneNumber));

  @override
  Stream<String?> get outputIsProfilePictureValid =>
      _profilePictureStreamController.stream.map((link) => _validPicture(link));

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUsecase.execute(RegisterUseCaseInput(
            registerObject.name,
            registerObject.countryCode,
            registerObject.numberPhone,
            registerObject.email,
            registerObject.password)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                },
            (data) => {
                  inputState.add(SuccessState(
                      StateRendererType.POPUP_SUCCESS_STATE,
                      "Register success. Please Login")),
                  isRegisterSuccessStreamController.add(true)
                });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    registerObject = registerObject.copyWith(email: email);
    _validate();
  }

  @override
  setName(String name) {
    inputName.add(name);
    registerObject = registerObject.copyWith(name: name);
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    registerObject = registerObject.copyWith(password: password);
    _validate();
  }

  @override
  setPhoneNumber(String numberPhone) {
    inputPhoneNumber.add(numberPhone);
    registerObject = registerObject.copyWith(numberPhone: numberPhone);
    _validate();
  }

  @override
  setProfilePicture(String picture) {
    inputPicture.add(picture);
    registerObject = registerObject.copyWith(pictureLink: picture);
    _validate();
  }

  @override
  setNumberCountryCode(String numberCountryCode) {
    registerObject = registerObject.copyWith(countryCode: numberCountryCode);
    _validate();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _nameStreamController.close();
    _numberPhoneStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllValueStreamController.close();
    super.dispose();
  }

  _validName(String name) {
    return name.isEmpty ? AppStrings.isNameEmpty : null;
  }

  _validPicture(String link) {
    return link.isEmpty ? null : link;
  }

  _validNumberPhone(String number) {
    return number.isEmpty ? AppStrings.isPhoneEmpty : null;
  }

  _validate() {
    inputIsAll.add(null);
  }

  _isAllValueValid() {
    return _validName(registerObject.name) == null &&
        _validNumberPhone(registerObject.numberPhone) == null &&
        _validPicture(registerObject.pictureLink) != null &&
        validateEmail(registerObject.email) == null &&
        validatePassword(registerObject.password) == null;
  }
}
