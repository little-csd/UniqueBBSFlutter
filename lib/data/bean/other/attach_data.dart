import 'package:json_annotation/json_annotation.dart';

part 'attach_data.g.dart';

@JsonSerializable()
class AttachData {
  String? originalName;
  @JsonKey(name: 'filesize')
  int? fileSize;
  String? createDate;
  String? fileName;
  @JsonKey(name: 'id')
  String? aid;
  int? downloads;

  factory AttachData.fromJson(Map<String, dynamic> json) =>
      _$AttachDataFromJson(json);
  Map<String, dynamic> toJson() => _$AttachDataToJson(this);

  AttachData(this.originalName, this.fileSize, this.createDate, this.fileName,
      this.aid, this.downloads);
}
