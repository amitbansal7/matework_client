// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AuthRestClient implements AuthRestClient {
  _AuthRestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.1.8:3000/api/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<Map<String, dynamic>>> sendOtp(phoneNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'phone_number': phoneNumber};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<Map<String, dynamic>>>(Options(
                method: 'POST',
                headers: <String, dynamic>{},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'o/users/login',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<Map<String, dynamic>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<AuthResponse>> verify(phoneNumber, otp) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'phone_number': phoneNumber, 'otp': otp};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<AuthResponse>>(Options(
                method: 'POST',
                headers: <String, dynamic>{},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'o/users/verify',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<AuthResponse>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<AuthResponse>> auth() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<AuthResponse>>(Options(
                method: 'GET',
                headers: <String, dynamic>{},
                extra: _extra,
                contentType: 'application/x-www-form-urlencoded')
            .compose(_dio.options, 'users/auth',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<AuthResponse>.fromJson(_result.data!);
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
