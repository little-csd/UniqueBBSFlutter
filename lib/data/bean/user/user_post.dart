import 'package:UniqueBBS/data/bean/user/post_thread.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_post.g.dart';

@JsonSerializable()
class UserPost {
  @JsonKey(name: 'list')
  List<PostThread> posts;
  int count;

  factory UserPost.fromJson(Map<String, dynamic> json) =>
      _$UserPostFromJson(json);
  Map<String, dynamic> toJson() => _$UserPostToJson(this);

  UserPost(this.posts, this.count);
}
