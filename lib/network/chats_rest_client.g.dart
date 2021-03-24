// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'chats_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ChatsRestClient implements ChatsRestClient {
  _ChatsRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.1.8:3000/api/v1/chats';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ApiResponse<ChatsResponse>> getAllChatUsers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResponse<ChatsResponse>.fromJson(
      _result.data,
      (json) => ChatsResponse.fromJson(json),
    );
    return value;
  }
}
