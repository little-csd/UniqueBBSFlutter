// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mentor _$MentorFromJson(Map<String, dynamic> json) {
  return Mentor(
    UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    UserInfo.fromJson(json['mentor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MentorToJson(Mentor instance) => <String, dynamic>{
      'user': instance.user,
      'mentor': instance.mentor,
    };
