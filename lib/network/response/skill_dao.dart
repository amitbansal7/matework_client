import 'package:json_annotation/json_annotation.dart';

part 'skill_dao.g.dart';

@JsonSerializable()
class SkillDao {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'rating')
  final int rating;

  SkillDao({required this.name, required this.rating});

  factory SkillDao.fromJson(Map<String, dynamic> json) =>
      _$SkillDaoFromJson(json);
  Map<String, dynamic> toJson() => _$SkillDaoToJson(this);
}
