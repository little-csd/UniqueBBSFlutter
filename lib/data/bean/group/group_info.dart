import 'package:json_annotation/json_annotation.dart';

part 'group_info.g.dart';

@JsonSerializable()
class GroupInfo {
  String id;
  int key;
  String name;
  String color;

  factory GroupInfo.fromJson(Map<String, dynamic> json) =>
      _$GroupInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GroupInfoToJson(this);

  GroupInfo(this.id, this.key, this.name, this.color);
}
