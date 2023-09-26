import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  final String code;
  final String name;
  final String zipCode;
  final String uf;

  City({
    this.code,
    this.name,
    this.zipCode,
    this.uf,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
