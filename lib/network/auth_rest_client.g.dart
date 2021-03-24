// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'auth_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AuthRestClient implements AuthRestClient {
  _AuthRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.1.8:3000/api/v1/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ApiResponse<AuthResponse>> sendOtp(phoneNumber) async {
    ArgumentError.checkNotNull(phoneNumber, 'phoneNumber');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'phone_number': phoneNumber};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('o/users/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResponse<AuthResponse>.fromJson(
      _result.data,
      (json) => AuthResponse.fromJson(json),
    );
    return value;
  }

  @override
  Future<ApiResponse<AuthResponse>> verify(phoneNumber, otp) async {
    ArgumentError.checkNotNull(phoneNumber, 'phoneNumber');
    ArgumentError.checkNotNull(otp, 'otp');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'phone_number': phoneNumber, 'otp': otp};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('o/users/verify',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResponse<AuthResponse>.fromJson(
      _result.data,
      (json) => AuthResponse.fromJson(json),
    );
    return value;
  }

  @override
  Future<ApiResponse<AuthResponse>> auth() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('users/auth',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResponse<AuthResponse>.fromJson(
      _result.data,
      (json) => AuthResponse.fromJson(json),
    );
    return value;
  }
}
