import 'package:json_annotation/json_annotation.dart';
import 'package:unique_bbs/data/bean/user/user_info.dart';

part 'mentor.g.dart';

@JsonSerializable()
class Mentor {
  UserInfo user;
  UserInfo mentor;

  factory Mentor.fromJson(Map<String, dynamic> json) => _$MentorFromJson(json);
  Map<String, dynamic> toJson() => _$MentorToJson(this);

  Mentor(this.user, this.mentor);
}
