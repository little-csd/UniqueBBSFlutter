import 'package:UniqueBBSFlutter/data/bean/group/group_info.dart';
import 'package:UniqueBBSFlutter/data/bean/user/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  GroupInfo info;
  UserInfo master;
  int count;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group(this.info, this.master, this.count);
}
