import 'package:UniqueBBSFlutter/data/bean/forum/post_search_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_search.g.dart';

@JsonSerializable()
class PostSearch {
  List<PostSearchData> result;
  int count;

  factory PostSearch.fromJson(Map<String, dynamic> json) =>
      _$PostSearchFromJson(json);
  Map<String, dynamic> toJson() => _$PostSearchToJson(this);

  PostSearch(this.result, this.count);
}
