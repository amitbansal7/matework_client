// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ChatsRestClient implements ChatsRestClient {
  _ChatsRestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.1.6:3000/api/v1/chats';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<ChatsResponse>> getAllChatUsers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<ChatsResponse>>(Options(
                method: 'GET',
                headers: <String, dynamic>{},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<ChatsResponse>.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
