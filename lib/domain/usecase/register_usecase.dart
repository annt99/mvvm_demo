import 'package:mvvm_demo/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/domain/model/model.dart';
import 'package:mvvm_demo/domain/repository/repository.dart';
import 'package:mvvm_demo/domain/usecase/base_usecase.dart';

class RegisterUseCaseInput {
  String name;
  String countryNumCode;
  String mobileNumber;
  String email;
  String password;
  RegisterUseCaseInput(this.name, this.countryNumCode, this.mobileNumber,
      this.email, this.password);
}

class RegisterUsecase implements BaseUseCase<RegisterUseCaseInput, Register> {
  final Repository _repository;
  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, Register>> execute(RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(input.countryNumCode,
        input.name, input.email, input.password, input.mobileNumber, ""));
  }
}
