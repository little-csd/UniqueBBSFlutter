import 'package:UniqueBBSFlutter/data/bean/forum/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'posts.g.dart';

@JsonSerializable()
class Posts {
  @JsonKey(name: 'list')
  List<Post> posts;
  int count;

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
  Map<String, dynamic> toJson() => _$PostsToJson(this);

  Posts(this.posts, this.count);
}
