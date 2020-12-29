import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/widget/post/post_list.dart';
import 'package:flutter/material.dart';

const pageSize = 20;

class ForumPageWidget extends StatefulWidget {
  final String titleText = "新人任务";

  @override
  State<StatefulWidget> createState() => ForumPageState();
}

class ForumPageState extends State<ForumPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.backgroundLightGrey,
          title: Text(
            widget.titleText,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: _buildBody(context));
  }
}

_buildBody(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ForumListCard(
              showLabel: false,
              showLoadMore: false,
              canScroll: false,
              bodyHeight: 2000,
            ),
            _buildBottomText()
          ],
        )),
  );
}

_buildBottomText() {
  return Container(
    padding: EdgeInsets.all(20),
    child: Text(
      StringConstant.noMoreForum,
      style: TextStyle(
          fontSize: 13, color: ColorConstant.textLightPurPle, letterSpacing: 3),
    ),
  );
}
