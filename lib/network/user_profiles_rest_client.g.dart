// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profiles_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserProfilesRestClient implements UserProfilesRestClient {
  _UserProfilesRestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.1.4:3000/api/v1/profiles';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<UserProfileResponse>> getProfileById(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<UserProfileResponse>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/$id',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<UserProfileResponse>.fromJson(_result.data!);
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
