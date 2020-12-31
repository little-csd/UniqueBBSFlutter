import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/full_forum.dart';
import 'package:UniqueBBSFlutter/data/model/forum_model.dart';
import 'package:UniqueBBSFlutter/data/model/thread_model.dart';
import 'package:UniqueBBSFlutter/widget/post/post_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _theOnlyForum = "闲杂讨论";

class HomeForumWidget extends StatefulWidget {
  @override
  State createState() => _HomeForumState();
}

// todo : refactor
class _HomeForumState extends State<HomeForumWidget> {



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForumModel>(builder: (context, model, child) {
      // todo : test code, delete later
      FullForum forum = model.findByName(_theOnlyForum);
      var count = forum.threadCount;
      print("sunkaiyi $count");
      var threadModel = ThreadModel(model.findByName(_theOnlyForum), false);
      var count2 = threadModel.threadCount;
      Future.delayed(Duration(milliseconds: 500), () {
        threadModel.fetch();
      });

    return Stack(
      children: [
        Positioned(
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
                child: ForumListCard(
                  model: threadModel,
                  showLabel: true,
                  showLoadMore: true,
                  canScroll: false,
                  forum: model.findByName(_theOnlyForum),
                  maxLength: 1,
                ),
              ),
              itemCount: 1,
            ),
          ),
        ],
      );
    });
  }
}
