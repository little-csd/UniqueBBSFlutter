// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSearch _$PostSearchFromJson(Map<String, dynamic> json) {
  return PostSearch(
    (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : PostSearchData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$PostSearchToJson(PostSearch instance) =>
    <String, dynamic>{
      'result': instance.result,
      'count': instance.count,
    };
