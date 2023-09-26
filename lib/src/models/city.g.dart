// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    code: json['code'] as String,
    name: json['name'] as String,
    zipCode: json['zipCode'] as String,
    uf: json['uf'] as String,
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'zipCode': instance.zipCode,
      'uf': instance.uf,
    };
