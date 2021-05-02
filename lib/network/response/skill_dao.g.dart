// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_dao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillDao _$SkillDaoFromJson(Map<String, dynamic> json) {
  return SkillDao(
    name: json['name'] as String,
    rating: json['rating'] as int,
  );
}

Map<String, dynamic> _$SkillDaoToJson(SkillDao instance) => <String, dynamic>{
      'name': instance.name,
      'rating': instance.rating,
    };
