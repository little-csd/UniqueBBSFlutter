import 'package:UniqueBBSFlutter/widget/forum_item.dart';
import 'package:flutter/material.dart';

class HomeForumWidget extends StatefulWidget {
  @override
  State createState() => _HomeForumState();
}

// TODO: store forum data here and deliver to @ForumItem
class _HomeForumState extends State<HomeForumWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ForumItem(),
      itemCount: 10,
    );
  }
}
