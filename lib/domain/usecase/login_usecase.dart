import 'package:mvvm_demo/app/funtions.dart';
import 'package:mvvm_demo/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/domain/model/model.dart';
import 'package:mvvm_demo/domain/repository/repository.dart';
import 'package:mvvm_demo/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(
        input.email, input.password, deviceInfo.identifier, deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
