// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageItem _$MessageItemFromJson(Map<String, dynamic> json) {
  return MessageItem(
    json['createDate'] as String,
    json['url'] as String,
    json['id'] as String,
    json['isRead'] as bool,
    json['message'] as String,
  );
}

Map<String, dynamic> _$MessageItemToJson(MessageItem instance) =>
    <String, dynamic>{
      'createDate': instance.createDate,
      'url': instance.url,
      'id': instance.mid,
      'isRead': instance.isRead,
      'message': instance.message,
    };
