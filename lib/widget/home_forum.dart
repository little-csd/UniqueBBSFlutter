import 'package:UniqueBBSFlutter/widget/post/post_list.dart';
import 'package:flutter/material.dart';

class HomeForumWidget extends StatefulWidget {
  @override
  State createState() => _HomeForumState();
}

// TODO: store forum data here and deliver to @ForumItem
class _HomeForumState extends State<HomeForumWidget> {
  @override
  Widget build(BuildContext context) {
    ForumListCard listCard = ForumListCard(
      showLabel: true,
      showLoadMore: true,
      canScroll: false,
      bodyHeight: null,
    );

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.only(
              right: 20,
              top: 20,
              left: 20,
            ),
            child: listCard,
          ),
          itemCount: 1,
        ));
  }
}
