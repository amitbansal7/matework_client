// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileDao _$UserProfileDaoFromJson(Map<String, dynamic> json) {
  return UserProfileDao(
    id: json['id'] as int,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    avatar: json['avatar'] as String?,
    shortBio: json['short_bio'] as String?,
    longBio: json['long_bio'] as String?,
    experience: (json['experience'] as num?)?.toDouble(),
    age: json['age'] as int?,
    externalLink: json['external_link'] as String?,
    location: json['location'] as String?,
    lookingFor: json['looking_for'] as String?,
    skills: (json['skills'] as List<dynamic>)
        .map((e) => SkillDao.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserProfileDaoToJson(UserProfileDao instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
      'short_bio': instance.shortBio,
      'long_bio': instance.longBio,
      'experience': instance.experience,
      'age': instance.age,
      'external_link': instance.externalLink,
      'location': instance.location,
      'looking_for': instance.lookingFor,
      'skills': instance.skills,
    };
