import 'package:mvvm_demo/data/data_source/remote_data_source.dart';
import 'package:mvvm_demo/data/mapper/mapper.dart';
import 'package:mvvm_demo/data/network/error_handler.dart';
import 'package:mvvm_demo/data/network/network_info.dart';
import 'package:mvvm_demo/domain/model/model.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //return data
          return Right(response.toDomain());
        } else {
          //return error
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.UNKNOWN));
        }
      } catch (error) {
        return Left(ErrorHandler.handler(error).failure);
      }
    } else {
      //return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
