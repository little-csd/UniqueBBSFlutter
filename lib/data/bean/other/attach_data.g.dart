// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attach_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachData _$AttachDataFromJson(Map<String, dynamic> json) {
  return AttachData(
    json['originalName'] as String?,
    json['filesize'] as int?,
    json['createDate'] as String?,
    json['fileName'] as String?,
    json['id'] as String?,
    json['downloads'] as int?,
  );
}

Map<String, dynamic> _$AttachDataToJson(AttachData instance) =>
    <String, dynamic>{
      'originalName': instance.originalName,
      'filesize': instance.fileSize,
      'createDate': instance.createDate,
      'fileName': instance.fileName,
      'id': instance.aid,
      'downloads': instance.downloads,
    };
