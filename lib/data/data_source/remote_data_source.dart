import 'package:mvvm_demo/data/network/app_api.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticaitonResponse> login(LoginRequest loginRequest);
  Future<ForgetPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);
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
}
