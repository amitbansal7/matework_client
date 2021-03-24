// @dart=2.9

import 'package:Matework/network/response/chats_response.dart';
import 'package:Matework/network/response/invites_response.dart';
import 'package:json_annotation/json_annotation.dart';
import './auth_response.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> {
  final bool success;
  final String message;
  @_Converter()
  final T data;

  ApiResponse({this.success, this.message, this.data});

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Map<String, dynamic>) name) =>
      _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('user') &&
        json.containsKey('token')) {
      return AuthResponse.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && json.containsKey('invites')) {
      return InvitesResponse.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && json.containsKey('chats')) {
      return ChatsResponse.fromJson(json) as T;
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
