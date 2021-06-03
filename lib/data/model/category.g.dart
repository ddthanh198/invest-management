// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    json['id'] as int?,
    json['name'] as String?,
    json['image'] as String?,
    json['color'] as String?,
  )
    ..assets = (json['assets'] as List<dynamic>)
        .map((e) => Asset.fromJson(e as Map<String, dynamic>))
        .toList()
    ..totalCapital = json['totalCapital'] as int
    ..totalProfit = json['totalProfit'] as int
    ..totalProfitPercent = (json['totalProfitPercent'] as num).toDouble();
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'color': instance.color,
      'assets': instance.assets,
      'totalCapital': instance.totalCapital,
      'totalProfit': instance.totalProfit,
      'totalProfitPercent': instance.totalProfitPercent,
    };
