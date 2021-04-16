import 'package:json_annotation/json_annotation.dart';

part 'basic_forum.g.dart';

@JsonSerializable()
class BasicForum {
  String name;
  String description;
  String icon;
  @JsonKey(name: 'id')
  String fid;
  @JsonKey(name: 'threads')
  int threadCount;

  factory BasicForum.fromJson(Map<String, dynamic> json) =>
      _$BasicForumFromJson(json);
  Map<String, dynamic> toJson() => _$BasicForumToJson(this);

  BasicForum(
      this.name, this.description, this.icon, this.fid, this.threadCount);
}
