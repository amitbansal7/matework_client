import 'package:Matework/network/response/api_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import './response/auth_response.dart';
import './response/api_response.dart';
part 'auth_rest_client.g.dart';

@RestApi(baseUrl: "http://192.168.1.7:3000/api/v1/")
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String baseUrl}) = _AuthRestClient;

  @POST("o/users/login")
  @FormUrlEncoded()
  Future<ApiResponse<AuthResponse>> sendOtp(
      @Field("phone_number") String phoneNumber);

  @POST("o/users/verify")
  @FormUrlEncoded()
  Future<ApiResponse<AuthResponse>> verify(
      @Field("phone_number") String phoneNumber, @Field("otp") String otp);

  @GET("users/auth")
  @FormUrlEncoded()
  Future<ApiResponse<AuthResponse>> auth();
}
