// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mentee _$MenteeFromJson(Map<String, dynamic> json) {
  return Mentee(
    (json['students'] as List)
        ?.map((e) =>
            e == null ? null : UserInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['mentor'] == null
        ? null
        : UserInfo.fromJson(json['mentor'] as Map<String, dynamic>),
    json['my'] == null
        ? null
        : UserInfo.fromJson(json['my'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MenteeToJson(Mentee instance) => <String, dynamic>{
      'students': instance.students,
      'mentor': instance.mentor,
      'my': instance.my,
    };
