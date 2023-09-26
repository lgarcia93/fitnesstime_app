import 'package:fitness_time/src/models/city.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setup_response.g.dart';

@JsonSerializable()
class SetupResponse {
  final List<City> cities;
  final List<Skill> skills;

  SetupResponse({
    this.cities,
    this.skills,
  });

  factory SetupResponse.fromJson(Map<String, dynamic> json) =>
      _$SetupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetupResponseToJson(this);
}
