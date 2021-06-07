// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _InvitesRestClient implements InvitesRestClient {
  _InvitesRestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.1.8:3000/api/v1/invites';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<InvitesResponse>> getAllInvites() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<InvitesResponse>>(Options(
                method: 'GET',
                headers: <String, dynamic>{},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<InvitesResponse>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<InvitesResponse>> createInvite(toUserId, message) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'to_user_id': toUserId, 'message': message};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<InvitesResponse>>(Options(
                method: 'POST',
                headers: <String, dynamic>{},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<InvitesResponse>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> acceptInvite(inviteId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'invite_id': inviteId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<Map<String, dynamic>>>(Options(
                method: 'PUT',
                headers: <String, dynamic>{},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '/accept',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<Map<String, dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> deleteInvite(inviteId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'invite_id': inviteId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<Map<String, dynamic>>>(Options(
                method: 'DELETE',
                headers: <String, dynamic>{},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, '',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<Map<String, dynamic>>.fromJson(_result.data!);
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
