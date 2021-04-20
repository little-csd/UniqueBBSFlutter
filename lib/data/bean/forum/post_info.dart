import 'package:json_annotation/json_annotation.dart';

part 'post_info.g.dart';

@JsonSerializable()
class PostInfo {
  String? createDate;
  bool? isFirst;
  String? quote;
  @JsonKey(name: 'id')
  String? pid;
  String? message;
  bool? active;

  factory PostInfo.fromJson(Map<String, dynamic> json) =>
      _$PostInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PostInfoToJson(this);

  PostInfo(this.createDate, this.isFirst, this.quote, this.pid, this.message,
      this.active);
}
