// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mentee _$MenteeFromJson(Map<String, dynamic> json) {
  return Mentee(
    (json['students'] as List<dynamic>)
        .map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    UserInfo.fromJson(json['mentor'] as Map<String, dynamic>),
    UserInfo.fromJson(json['my'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MenteeToJson(Mentee instance) => <String, dynamic>{
      'students': instance.students,
      'mentor': instance.mentor,
      'my': instance.my,
    };
