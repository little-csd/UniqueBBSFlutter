import 'package:UniqueBBS/data/bean/group/group_info.dart';
import 'package:UniqueBBS/data/bean/user/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  GroupInfo? group;
  UserInfo? master;
  int? count;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group(this.group, this.master, this.count);
}
