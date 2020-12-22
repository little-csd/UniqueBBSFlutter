import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/widget/post/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
final divider = Container(
  height: 1,
  margin: EdgeInsets.symmetric(vertical: 8.0),
  color: ColorConstant.backgroundGrey,
);

// todo : refactor
class ForumListCard extends StatefulWidget {
  // 标题相关
  final bool showLabel;
  final bool showLoadMore;

  ForumListCard(
    this.showLoadMore,
    this.showLabel,
  );

  @override
  State<StatefulWidget> createState() => ForumListCardState();
}

class ForumListCardState extends State<ForumListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.backgroundPurple,
            blurRadius: 3.0,
          ),
        ],
        color: ColorConstant.backgroundLightGrey,
      ),
      child: Column(children: [
        if (widget.showLabel) Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(SvgIcon.projectTask),
                Container(
                  width: 5,
                ),
                Text("多给点吧",
                  style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 2,
                      color: ColorConstant.purpleColor
                  ),)
              ],
            ),
          ),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: ForumItem2(),
                  ),
              itemCount: 3,
              separatorBuilder: (BuildContext context, int index) => divider),
        ),
        if(widget.showLoadMore)_buildLoadMoreButton(context)
      ]),
    );
  }
}

_buildLoadMoreButton(BuildContext context) => Container(
    alignment: Alignment.center,
    child: SizedBox(
      child: FlatButton(
        height: 20,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorConstant.weComButtonGray),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text(StringConstant.loadMore,
        style: TextStyle(
          color: ColorConstant.textGrey,
          fontSize: 14
        ),),
        onPressed: () {},
      ),
    ));
