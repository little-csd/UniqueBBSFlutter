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
  final bool canScroll;
  final double bodyHeight;

  ForumListCard(
      {this.showLoadMore, this.showLabel, this.canScroll, this.bodyHeight});

  @override
  State<StatefulWidget> createState() => ForumListCardState();

}

class ForumListCardState extends State<ForumListCard> {
  var _words = <String>['loading'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstant.lightBorderPink,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.lightBorderPink,
            blurRadius: 10.0,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(children: [
        if (widget.showLabel)
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(SvgIcon.projectTask),
                Container(
                  width: 5,
                ),
                Text(
                  "多给点吧",
                  style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 2,
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
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: ForumItem2(),
                );
              },
              itemCount: widget.showLoadMore ? 3 : _words.length,
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

  void receiveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      var addList = <String>["sss", "sss", "ssss", "ssss"];
      setState(() {
        _words.insertAll(_words.length - 1, addList);
      });
    });
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
        child: Text(
          StringConstant.loadMore,
          style: TextStyle(color: ColorConstant.textGrey, fontSize: 14),
        ),
        onPressed: () {},
      ),
    ));

_shrinkWrap(int containerHeight) {
  return (containerHeight == null);
}

_itemCount(int height) {
  if (height == null) {
    return 3;
  } else {
    return 15;
  }
}

_canScroll(ForumListCard widget) {
  if (widget.canScroll) {
    return null;
  } else {
    return NeverScrollableScrollPhysics();
  }
}
