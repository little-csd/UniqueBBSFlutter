import 'package:UniqueBBS/data/bean/user/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mentee.g.dart';

@JsonSerializable()
class Mentee {
  List<UserInfo> students;
  UserInfo mentor;
  UserInfo my;

  factory Mentee.fromJson(Map<String, dynamic> json) => _$MenteeFromJson(json);
  Map<String, dynamic> toJson() => _$MenteeToJson(this);

  Mentee(this.students, this.mentor, this.my);
}
