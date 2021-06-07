// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return Asset(
    json['id'] as int?,
    json['categoryId'] as int?,
    json['name'] as String?,
    json['capital'] as int?,
    json['profit'] as int?,
    (json['profitPercent'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'capital': instance.capital,
      'profit': instance.profit,
      'profitPercent': instance.profitPercent,
    };
