import 'package:Matework/network/response/skill_dao.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_dao.g.dart';

@JsonSerializable()
class UserProfileDao {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "last_name")
  final String lastName;

  @JsonKey(name: "avatar")
  final String? avatar;

  @JsonKey(name: "short_bio")
  final String? shortBio;

  @JsonKey(name: "long_bio")
  final String? longBio;

  @JsonKey(name: "experience")
  final double? experience;

  @JsonKey(name: "age")
  final int? age;

  @JsonKey(name: "external_link")
  final String? externalLink;

  @JsonKey(name: "location")
  final String? location;

  @JsonKey(name: "looking_for")
  final String? lookingFor;

  @JsonKey(name: "skills")
  final List<SkillDao> skills;

  UserProfileDao(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.shortBio,
      required this.longBio,
      required this.experience,
      required this.age,
      required this.externalLink,
      required this.location,
      required this.lookingFor,
      required this.skills});

  factory UserProfileDao.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDaoFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileDaoToJson(this);
}
