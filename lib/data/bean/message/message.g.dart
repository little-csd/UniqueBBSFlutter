// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['messageItem'] == null
        ? null
        : MessageItem.fromJson(json['messageItem'] as Map<String, dynamic>),
    json['fromUser'] == null
        ? null
        : UserInfo.fromJson(json['fromUser'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'messageItem': instance.messageItem,
      'fromUser': instance.fromUser,
    };
