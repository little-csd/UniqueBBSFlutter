import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/config/route.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/full_forum.dart';
import 'package:UniqueBBSFlutter/data/model/forum_model.dart';
import 'package:UniqueBBSFlutter/data/model/thread_model.dart';
import 'package:UniqueBBSFlutter/data/repo.dart';
import 'package:UniqueBBSFlutter/widget/post/thread_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

const _maxPreviewCount = 3;

const _bottomOffset = 50.0;
final _listSeparator = Container(height: 20);
final _listViewPadding = EdgeInsets.only(left: 20, right: 20, top: 15);

const _cardBorderRadius = 20.0;
const _cardTitleIconSize = 40.0;
final _cardItemSeparator = Container(height: 20);
final _cardPadding = EdgeInsets.only(left: 15, right: 19, top: 16, bottom: 18);
final _cardTitleNameStyle = TextStyle(
  color: ColorConstant.primaryColor,
  fontSize: 18,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.5,
);

const _loadMoreTextPaddingV = 3.0;
const _loadMoreTextPaddingH = 20.0;
const _loadMoreBorderRadius = 20.0;
final _loadMoreTextStyle =
    TextStyle(fontSize: 12, color: ColorConstant.textGrey, letterSpacing: 1);

/// forumData 每个元素为论坛的名字以及 svg 图标的 url
const _forumMetaData = [
  [StringConstant.discussion, SvgIcon.projectTask],
];

_buildForumBg() => Positioned(
      child: Container(
        child: Image.asset(
          PngIcon.homeForumBg,
          fit: BoxFit.fill,
        ),
        width: double.infinity,
      ),
      bottom: 0,
      left: 0,
      right: 0,
    );

_buildForumCardHead(String name, String iconUrl) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconUrl,
          width: _cardTitleIconSize,
          height: _cardTitleIconSize,
        ),
        Text(
          ' $name',
          style: _cardTitleNameStyle,
        ),
      ],
    );

_buildLoadMore(FullForum forum, BuildContext context) => GestureDetector(
      onTap: () {
        if (forum == null) return;
        Navigator.of(context).pushNamed(BBSRoute.postList, arguments: forum);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: _loadMoreTextPaddingV, horizontal: _loadMoreTextPaddingH),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_loadMoreBorderRadius),
          border: Border.all(color: ColorConstant.textGrey),
        ),
        child: Text(
          StringConstant.loadMore,
          style: _loadMoreTextStyle,
        ),
      ),
    );

_buildCardItems() => Consumer<ThreadModel>(builder: (context, model, child) {
      final items = List<Widget>();
      for (int i = 0; i < _maxPreviewCount; i++) {
        final user = model.getUserInfo(i);
        final thread = model.getThreadInfo(i);
        if (user == null || thread == null) {
          model.fetch();
          break;
        }
        items.add(ThreadItem(thread, user));
      }
      return Column(children: items);
    });

Widget _buildForumCard(
    String name, String iconUrl, FullForum forum, BuildContext context) {
  if (forum == null) return Container();
  ThreadModel model = Repo.instance.cacheThreadModels[name];
  if (model == null) {
    model = ThreadModel(forum);
    Repo.instance.cacheThreadModels[name] = model;
  }
  return ChangeNotifierProvider.value(
    value: model,
    child: Container(
      padding: _cardPadding,
      decoration: BoxDecoration(
        color: ColorConstant.backgroundWhite,
        borderRadius: BorderRadius.circular(_cardBorderRadius),
      ),
      child: Column(
        children: [
          _buildForumCardHead(name, iconUrl),
          _cardItemSeparator,
          _buildCardItems(),
          _cardItemSeparator,
          _buildLoadMore(forum, context),
        ],
      ),
    ),
  );
}

class HomeForumWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ForumModel>(builder: (context, model, child) {
      /// 这里最后添加了一个 container 是为了保证 listview 滑到最底部不会被底部栏挡到
      /// 同时滑动过程中也可以透过底部栏看到 forum 信息
      final forumCards = _forumMetaData
          .map((data) => _buildForumCard(
              data[0], data[1], model.findByName(data[0]), context))
          .toList()
            ..add(Container(height: _bottomOffset));
      return Stack(children: [
        ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: _listViewPadding,
          itemBuilder: (context, index) => forumCards[index],
          itemCount: forumCards.length,
          separatorBuilder: (context, index) => _listSeparator,
        ),
        _buildForumBg()
      ]);
    });
  }
}
