import 'package:Matework/models/invite.dart';
import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/network/response/invites_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import '../utils.dart';
import './response/auth_response.dart';
import './response/api_response.dart';
part 'invites_rest_client.g.dart';

@RestApi(baseUrl: "$BASE_API_URL/v1/invites")
abstract class InvitesRestClient {
  factory InvitesRestClient(Dio dio, {String baseUrl}) = _InvitesRestClient;
  @GET("/")
  @FormUrlEncoded()
  Future<ApiResponse<InvitesResponse>> getAllInvites();

  @POST("/")
  @FormUrlEncoded()
  Future<ApiResponse<InvitesResponse>> createInvite(
    @Field("to_user_id") int toUserId,
    @Field("message") String message,
  );

  @PUT("/accept")
  @FormUrlEncoded()
  Future<ApiResponse<Map<String, dynamic>>> acceptInvite(
      @Field("invite_id") int inviteId);

  @DELETE("")
  @FormUrlEncoded()
  Future<ApiResponse<Map<String, dynamic>>> deleteInvite(
      @Field("invite_id") int inviteId);
}
