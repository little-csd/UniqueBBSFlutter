import 'package:UniqueBBSFlutter/widget/post/post_list.dart';
import 'package:flutter/material.dart';

const _bgHeight = 350.0;
const _bgUrl = 'images/home_forum_bg.png';

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

    return Stack(
      children: [
        Positioned(
          child: Container(
            child: Image.asset(_bgUrl),
            width: double.infinity,
          ),
          bottom: 0,
          left: 0,
          right: 0,
        ),
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.only(
                  right: 20,
                  top: 20,
                  left: 20,
                ),
                child: listCard,
              ),
              itemCount: 1,
            )),
      ],
    );
  }
}
