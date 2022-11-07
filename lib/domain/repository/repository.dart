import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/data/network/failure.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);
  Future<Either<Failure, Register>> register(RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHome();
}
