// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'invites_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _InvitesRestClient implements InvitesRestClient {
  _InvitesRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.1.8:3000/api/v1/invites';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ApiResponse<InvitesResponse>> getAllInvites() async {
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
    final value = ApiResponse<InvitesResponse>.fromJson(
      _result.data,
      (json) => InvitesResponse.fromJson(json),
    );
    return value;
  }

  @override
  Future<ApiResponse<String>> acceptInvite(inviteId) async {
    ArgumentError.checkNotNull(inviteId, 'inviteId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'invite_id': inviteId};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/accept',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResponse<String>.fromJson(
      _result.data,
      (json) => json as String,
    );
    return value;
  }

  @override
  Future<ApiResponse<String>> deleteInvite(inviteId) async {
    ArgumentError.checkNotNull(inviteId, 'inviteId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'invite_id': inviteId};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResponse<String>.fromJson(
      _result.data,
      (json) => json as String,
    );
    return value;
  }
}
