// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostInfo _$PostInfoFromJson(Map<String, dynamic> json) {
  return PostInfo(
    json['createDate'] as String?,
    json['isFirst'] as bool?,
    json['quote'] as String?,
    json['id'] as String?,
    json['message'] as String?,
    json['active'] as bool?,
  );
}

Map<String, dynamic> _$PostInfoToJson(PostInfo instance) => <String, dynamic>{
      'createDate': instance.createDate,
      'isFirst': instance.isFirst,
      'quote': instance.quote,
      'id': instance.pid,
      'message': instance.message,
      'active': instance.active,
    };
