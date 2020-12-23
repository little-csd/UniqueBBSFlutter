import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/widget/post/post_list.dart';
import 'package:flutter/material.dart';

class ForumPageWidget extends StatefulWidget {
  final String titleText = "闲杂讨论";

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
        body: _buildBody()
    );
  }
}

_buildBody() {
  return SingleChildScrollView(
    child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ForumListCard(false, false, true, 800), _buildNodeMoreText()],
        )),
  );
}

_buildNodeMoreText() {
  return Container(
    padding: EdgeInsets.all(20),
    child: Text(
      StringConstant.noMoreForum,
      style: TextStyle(
          fontSize: 13, color: ColorConstant.textLightPurPle, letterSpacing: 3),
    ),
  );
}
