import 'package:Matework/network/response/api_response.dart';
import 'package:Matework/network/response/chats_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import '../utils.dart';
import './response/api_response.dart';
part 'chats_rest_client.g.dart';

@RestApi(baseUrl: "${BASE_API_URL}/v1/chats")
abstract class ChatsRestClient {
  factory ChatsRestClient(Dio dio, {String baseUrl}) = _ChatsRestClient;
  @GET("/")
  @FormUrlEncoded()
  Future<ApiResponse<ChatsResponse>> getAllChatUsers();
}
