import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/data/model/thread_model.dart';
import 'package:UniqueBBS/widget/post/thread_item.dart';
import 'package:flutter/material.dart';

// card
const _listCardContainerPadding = 20.0;
const _listCardContainerBorderRadius = 20.0;
const _listCardContainerShadowRadius = 10.0;

// list internal
const _dividerHeight = 0.5;
const _dividerMargin = 10.0;
final divider = Container(
  height: _dividerHeight,
  margin: EdgeInsets.symmetric(vertical: _dividerMargin),
  color: ColorConstant.backgroundGrey,
);

class ThreadListCard extends StatefulWidget {
  // 标题相关
  final ThreadModel model;

  ThreadListCard(this.model);

  @override
  State<StatefulWidget> createState() => ThreadListCardState();
}

class ThreadListCardState extends State<ThreadListCard> {
  ThreadModel model;

  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>();
    for (int i = 0; i < model.threadCount; i++) {
      final thread = model.getThreadInfo(i);
      final user = model.getUserInfo(i);
      if (thread == null || user == null) break;
      if (!thread.active) continue;
      if (i > 0) children.add(divider);
      children.add(ThreadItem(thread, user));
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_listCardContainerPadding),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstant.borderLightPink,
        ),
        borderRadius: BorderRadius.circular(_listCardContainerBorderRadius),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.borderLightPink,
            blurRadius: _listCardContainerShadowRadius,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(children: children),
    );
  }
}
