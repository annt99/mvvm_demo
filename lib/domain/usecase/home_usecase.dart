import 'package:mvvm_demo/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/domain/model/model.dart';
import 'package:mvvm_demo/domain/repository/repository.dart';
import 'package:mvvm_demo/domain/usecase/base_usecase.dart';

class HomeUsecase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;
  HomeUsecase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void _) async {
    return await _repository.getHome();
  }
}
