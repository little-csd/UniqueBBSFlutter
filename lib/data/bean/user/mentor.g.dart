// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mentor _$MentorFromJson(Map<String, dynamic> json) {
  return Mentor(
    json['user'] == null
        ? null
        : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    json['mentor'] == null
        ? null
        : UserInfo.fromJson(json['mentor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MentorToJson(Mentor instance) => <String, dynamic>{
      'user': instance.user,
      'mentor': instance.mentor,
    };
