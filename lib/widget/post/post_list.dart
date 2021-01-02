import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/config/route.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/full_forum.dart';
import 'package:UniqueBBSFlutter/data/model/thread_model.dart';
import 'package:UniqueBBSFlutter/widget/post/thread_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// card
const _listCardContainerPadding = 20.0;
const _listCardContainerBorderRadius = 20.0;
const _listCardContainerShadowRadius = 10.0;
// title
const _listCardTitleBottomPadding = 20.0;
const _theOnlyForum = "闲杂讨论";
const _titleFontSize = 24.0;
const _titleLetterSpacing = 2.0;
final _titleCenterDivider = Container(
  width: 5,
);

// list internal
final _listInternalBottomPadding = 5.0;
const _topPostsCount = 2;
const _dividerHeight = 1.0;
const _dividerMargin = 8.0;
final divider = Container(
  height: _dividerHeight,
  margin: EdgeInsets.symmetric(vertical: _dividerMargin),
  color: ColorConstant.backgroundGrey,
);

// loadMore
const _loadMoreButtonHeight = 20.0;
const _loadMoreFontSize = 14.0;
const _loadMoreBorderRadius = 20.0;

class ForumListCard extends StatefulWidget {
  // 标题相关
  final bool showLabel;
  final bool showLoadMore;
  final bool canScroll;
  final ThreadModel model;
  final FullForum forum;
  final int maxLength;

  ForumListCard(
      {this.showLoadMore,
      this.showLabel,
      this.canScroll,
      this.model,
      this.forum,
      this.maxLength});

  @override
  State<StatefulWidget> createState() => ForumListCardState();
}

class ForumListCardState extends State<ForumListCard> {
  ThreadModel model;

  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_listCardContainerPadding),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstant.lightBorderPink,
        ),
        borderRadius: BorderRadius.circular(_listCardContainerBorderRadius),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.lightBorderPink,
            blurRadius: _listCardContainerShadowRadius,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(children: [
        if (widget.showLabel)
          Container(
            padding: EdgeInsets.only(bottom: _listCardTitleBottomPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(SvgIcon.projectTask),
                _titleCenterDivider,
                Text(
                  _theOnlyForum,
                  style: TextStyle(
                      fontSize: _titleFontSize,
                      letterSpacing: _titleLetterSpacing,
                      color: ColorConstant.purpleColor),
                )
              ],
            ),
          ),
        Container(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListView.separated(
              physics: _canScroll(widget),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                index = _getInternalIndex(index);
                if (model.getThreadInfo(index) == null) {
                  return null;
                }
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: _listInternalBottomPadding,
                  ),
                  child: ThreadItem(
                      model.getThreadInfo(index), model.getUserInfo(index)),
                );
              },
              itemCount: _getItemCount(),
              separatorBuilder: (BuildContext context, int index) {
                return divider;
              },
            ),
          ),
        ),
        if (widget.showLoadMore) _buildLoadMoreButton(context)
      ]),
    );
  }

  _getInternalIndex(int index) {
    if (widget.maxLength == null) {
      return index;
    } else {
      return index + _topPostsCount;
    }
  }

  _getItemCount() {
    if (widget.maxLength == null) {
      return model.threadCount > 0 ? model.threadCount - 1 : model.threadCount;
    } else {
      return widget.maxLength;
    }
  }

  _buildLoadMoreButton(BuildContext context) => Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: FlatButton(
          height: _loadMoreButtonHeight,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorConstant.weComButtonGray),
              borderRadius: BorderRadius.circular(_loadMoreBorderRadius)),
          child: Text(
            StringConstant.loadMore,
            style: TextStyle(
                color: ColorConstant.textGrey, fontSize: _loadMoreFontSize),
          ),
          onPressed: () {
            Navigator.pushNamed(context, BBSRoute.postList,
                arguments: widget.forum);
          },
        ),
      ));

  _canScroll(ForumListCard widget) {
    if (widget.canScroll) {
      return null;
    } else {
      return NeverScrollableScrollPhysics();
    }
  }
}
