
import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/data/bean/forum/post_list.dart';
import 'package:UniqueBBS/data/bean/forum/post_search.dart';
import 'package:UniqueBBS/data/bean/forum/post_search_data.dart';
import 'package:UniqueBBS/data/bean/forum/thread.dart';
import 'package:UniqueBBS/data/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../config/constant.dart';
import '../../../config/route.dart';

const _cancelSize = 15.0;
const _searchSize = 16.0;
const _maxInputLength = 30;
const _listCacheField = 100.0;
const _perPageCount = 20;
const _noDataSize = 200.0;
const _noDataPadding = 200.0;
const _userImgSize = 50.0;
// card
const _listCardContainerPadding = 20.0;
const _listCardContainerBorderRadius = 20.0;
const _listCardContainerShadowRadius = 10.0;

const _titleStyle = TextStyle(
  color: ColorConstant.textBlack,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
const _subtitleStyle = TextStyle(
  color: ColorConstant.textGrey,
  fontSize: 13,
  fontWeight: FontWeight.bold,
);

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String keyWord;
  List<PostSearchData?>? res = [];
  bool isEnd = false;
  late TextEditingController controller;
  late ScrollController scrollController;
  PostSearch? searchRes;
  @override
  void initState() {
    initController();
  }

  void initController() {
    controller = TextEditingController();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isEnd = _refetchData();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSearchPage(),
    );
  }

  _buildSearchPage() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        _buildSearchHead(),
        _buildSearchBody(),
      ],
    );
  }

  _buildSearchHead() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              cursorColor: ColorConstant.textPurpleForUpdate,
              style: TextStyle(
                color: ColorConstant.textBlack,
                fontSize: _searchSize,
              ),
              onSubmitted: _searchRequest,
              maxLength: _maxInputLength,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, right: 15),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              StringConstant.cancel,
              style: TextStyle(
                color: ColorConstant.textGreyForSearch,
                fontWeight: FontWeight.bold,
                fontSize: _cancelSize,
                letterSpacing: 2.0,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }

  _buildSearchBody() {
    if (searchRes == null || searchRes!.count == 0) {
      return _buildNotFindWidget();
    } else {
      return _buildIfFind();
    }
  }

  // 每次请求后都要置空结果
  _searchRequest(str) {
    keyWord = controller.text;
    res = [];
    isEnd = false;
    Future<NetRsp<PostSearch>> search = Server.instance!.postSearch(keyWord, 1);
    search.then((value) {
      setState(() {
        searchRes = value.data;
        res!.addAll(searchRes!.result!);
      });
    });
  }
  
  _buildSingleItem(PostSearchData data) {
    return GestureDetector(
      onTap: (){
        _requestSingleSearch(data);
      },
      child: ListTile(
          title: Text(
            data.subject!,
            style: _titleStyle,
          ),
          leading: ClipOval(
              child: Image.network(
            data.user!.avatar!,
            height: _userImgSize,
            width: _userImgSize,
          )),
          subtitle: Text(
            '${data.user!.username} ${data.createDate!.substring(0, 10)} 发布',
            style: _subtitleStyle,
          ),
      ),
    );
  }

  void _requestSingleSearch(PostSearchData data) {
    Future<NetRsp<PostList>> npl = Server.instance!.postsInThread(data.tid, 1);
    npl.then((value)  {
      if(!value.success){
        Fluttertoast.showToast(msg: StringConstant.networkError);
        return ;
      }
      PostList pl = value.data!;
      Thread thread = new Thread(pl.threadInfo,pl.threadAuthor,[]);
      Navigator.pushNamed(context, BBSRoute.postDetail,arguments: thread);
    });
  }

  _buildIfFind() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstant.borderLightPink,
              ),
              borderRadius:
                  BorderRadius.circular(_listCardContainerBorderRadius),
              boxShadow: [
                BoxShadow(
                  color: ColorConstant.borderLightPink,
                  blurRadius: _listCardContainerShadowRadius,
                ),
              ],
              color: Colors.white,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return _buildListViewItem(index);
              },
              controller: scrollController,
              itemCount: res!.length + 1,
              shrinkWrap: true,
              cacheExtent: _listCacheField,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1.0,
                  color: ColorConstant.backgroundGrey,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildListViewItem(index) {
    if (index == res!.length) {
      if (res!.length == searchRes!.count) {
        return _buildBottomText();
      } else {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: ColorConstant.primaryColor,
          ),
        );
      }
    } else {
      return _buildSingleItem(res![index]!);
    }
  }

  _buildNotFindWidget() {
    return Padding(
      padding: EdgeInsets.only(top: _noDataPadding),
      child: Column(
        children: [
          Center(
            child: SvgPicture.asset(
              SvgIcon.noSearchRes,
              height: _noDataSize,
              width: _noDataSize,
            ),
          ),
          Text(
            StringConstant.notFindStrOne,
          ),
          Text(
            StringConstant.notFindStrTwo,
          ),
        ],
      ),
    );
  }
  _buildBottomText() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Text(
          StringConstant.noMoreForum,
          style: TextStyle(
              fontSize: 13,
              color: ColorConstant.textLightPurPle,
              letterSpacing: 3),
        ),
      ),
    );
  }

  bool _refetchData() {
    if (res!.length < searchRes!.count!) {
      var page = res!.length / _perPageCount + 1;
      Future<NetRsp<PostSearch>> search =
          Server().postSearch(keyWord, page.toInt());
      search.then((value) {
        setState(() {
          searchRes = value.data;
          res!.insertAll(res!.length, searchRes!.result!);
        });
      });
      return false;
    }
    return true;
  }
}
