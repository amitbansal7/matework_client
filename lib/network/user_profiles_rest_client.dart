import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/network/response/user_profile_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import '../utils.dart';
import 'response/api_response.dart';
part 'user_profiles_rest_client.g.dart';

@RestApi(baseUrl: "$BASE_API_URL/v1/profiles")
abstract class UserProfilesRestClient {
  factory UserProfilesRestClient(Dio dio, {String baseUrl}) =
      _UserProfilesRestClient;

  @GET("/{id}")
  Future<ApiResponse<UserProfileResponse>> getProfileById(@Path("id") int id);
}
