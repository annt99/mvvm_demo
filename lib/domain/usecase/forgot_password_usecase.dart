import 'package:mvvm_demo/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/domain/repository/repository.dart';
import 'package:mvvm_demo/domain/usecase/base_usecase.dart';

class ForgotPasswordUsecase implements BaseUseCase<String, String> {
  final Repository _repository;
  ForgotPasswordUsecase(this._repository);
  @override
  Future<Either<Failure, String>> execute(String email) async {
    return await _repository.forgotPassword(ForgotPasswordRequest(email));
  }
}
