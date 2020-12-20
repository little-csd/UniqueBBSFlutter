import 'package:flutter/material.dart';

class PostListWidget extends StatefulWidget {

  // 标题相关
  final bool showLabel;
  String labelText;
  String labelIconSrc;
  
  final showLoadMore;
  final posts;

  PostListWidget({
    this.showLabel,
    this.showLoadMore,
    this.posts,
  });

  @override
  State<StatefulWidget> createState() => PostListWidgetState();
}

class PostListWidgetState extends State<PostListWidget> {

  @override
  Widget build(BuildContext context) {

  }

}


