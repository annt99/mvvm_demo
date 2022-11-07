import 'package:mvvm_demo/data/network/app_api.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticaitonResponse> login(LoginRequest loginRequest);
  Future<ForgetPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);
  Future<RegisterResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHome();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticaitonResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email,
        loginRequest.password, loginRequest.imei, loginRequest.deviceType);
  }

  @override
  Future<ForgetPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    return await _appServiceClient.forgotPassword(forgotPasswordRequest.email);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.countryMobileCode,
        registerRequest.name,
        registerRequest.email,
        registerRequest.password,
        registerRequest.mobileNumber,
        registerRequest.profilePicture);
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServiceClient.getHome();
  }
}
