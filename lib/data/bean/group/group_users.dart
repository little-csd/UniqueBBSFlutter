import 'package:UniqueBBS/data/bean/group/group_info.dart';
import 'package:UniqueBBS/data/bean/user/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_users.g.dart';

@JsonSerializable()
class GroupUsers {
  @JsonKey(name: 'list')
  List<UserInfo> users;
  GroupInfo info;

  factory GroupUsers.fromJson(Map<String, dynamic> json) =>
      _$GroupUsersFromJson(json);
  Map<String, dynamic> toJson() => _$GroupUsersToJson(this);

  GroupUsers(this.users, this.info);
}
