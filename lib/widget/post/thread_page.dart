import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/full_forum.dart';
import 'package:UniqueBBSFlutter/data/model/thread_model.dart';
import 'package:UniqueBBSFlutter/widget/post/post_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const pageSize = 20;

// todo : refactor
class ThreadPageWidget extends StatefulWidget {
  final FullForum forum;

  ThreadPageWidget(this.forum);

  @override
  State<StatefulWidget> createState() => ThreadPageState();
}

class ThreadPageState extends State<ThreadPageWidget> {
  ThreadModel model;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _initScrollController();
    model = ThreadModel(widget.forum, isMe: false);
    super.initState();
    _fetchData();
  }

  void _initScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  _fetchData() {
    model.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.backgroundLightGrey,
          title: Text(
            widget.forum.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Consumer<ThreadModel>(builder: (context, model, child) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ForumListCard(
                  model: model,
                  showLabel: false,
                  showLoadMore: false,
                  canScroll: false,
                ),
                _buildBottomText()
              ],
            )),
      );
    });
  }

  _buildBottomText() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        StringConstant.noMoreForum,
        style: TextStyle(
            fontSize: 13,
            color: ColorConstant.textLightPurPle,
            letterSpacing: 3),
      ),
    );
  }
}
