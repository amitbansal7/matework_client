import 'package:Matework/network/response/chats_response.dart';
import 'package:Matework/network/response/invites_response.dart';
import 'package:Matework/network/response/user_profile_response.dart';
import 'package:json_annotation/json_annotation.dart';
import './auth_response.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> {
  final bool success;
  final String message;
  @_Converter()
  final T data;

  ApiResponse(
      {required this.success, required this.message, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    final map = json as Map<String, dynamic>;
    if (map.containsKey('user') && map.containsKey('token')) {
      return AuthResponse.fromJson(map) as T;
    } else if (map.containsKey('invites')) {
      return InvitesResponse.fromJson(map) as T;
    } else if (map.containsKey('chats')) {
      return ChatsResponse.fromJson(map) as T;
    } else if (map.containsKey('profile')) {
      return UserProfileResponse.fromJson(map) as T;
    } else {
      return map as T;
    }
  }

  @override
  Object toJson(T object) {
    return T;
  }
}
