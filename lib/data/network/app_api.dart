import 'package:dio/dio.dart';
import 'package:mvvm_demo/app/constant.dart';
import 'package:mvvm_demo/data/response/responses.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customer/login")
  Future<AuthenticaitonResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );

  @POST("/customer/forgetPassword")
  Future<ForgetPasswordResponse> forgotPassword(@Field("email") String email);
}
