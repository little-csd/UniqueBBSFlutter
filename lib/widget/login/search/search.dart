import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/data/bean/forum/post_search.dart';
import 'package:UniqueBBS/data/bean/forum/post_search_data.dart';
import 'package:UniqueBBS/data/bean/forum/thread.dart';
import 'package:UniqueBBS/data/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

const _cancelSize = 15.0;
const _searchSize = 16.0;
const _maxInputLength = 30;
const _listCacheField = 100.0;
const _perPageCount = 20;
const _noDataSize = 200.0;
const _noDataPadding = 200.0;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyWord;
  List<PostSearchData> res = [];
  TextEditingController controller;
  ScrollController scrollController;
  PostSearch searchRes = null;
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
          _refetchData();
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
            padding: EdgeInsets.only(left: 16,right: 16),
            child: TextField(
              style: TextStyle(
                color: ColorConstant.textBlack,
                fontSize: _searchSize,
              ),
              maxLength: _maxInputLength,
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30,right: 15),
          child: GestureDetector(
            onTap: _searchRequest,
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
    if (searchRes == null || searchRes.count == 0) {
      return _buildNotFindWidget();
    } else {
      return _buildIfFind();
    }
  }

  _searchRequest() {
    keyWord = controller.text;
    Future<NetRsp<PostSearch>> search = Server().postSearch(keyWord, 1);
    search.then((value) {
      setState(() {
        res = [];
        searchRes = value.data;
        res.addAll(searchRes.result);
      });
    });
  }

  _buildSingleItem(PostSearchData data) {
    return ListTile(
      title: Text(data.subject),
      leading: ClipOval(
          child: Image.network(
        data.user.avatar,
        height: 50,
        width: 50,
      )),
      subtitle: Text('${data.user.username} ${data.createDate} 发布'),
    );
  }

  _buildIfFind() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) => _buildListViewItem(index),
          controller: scrollController,
          itemCount: res.length + 1,
          shrinkWrap: true,
          cacheExtent: _listCacheField,
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }

  _buildListViewItem(index) {
    if (index == res.length) {
      if (res.length == searchRes.count) {
        Fluttertoast.showToast(msg: StringConstant.resAllFind);
        return Container();
      } else {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: ColorConstant.primaryColor,
          ),
        );
      }
    } else {
      return _buildSingleItem(res[index]);
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

  void _refetchData() {
    if (res.length < searchRes.count) {
      var page = res.length / _perPageCount + 1;
      Future<NetRsp<PostSearch>> search =
          Server().postSearch(keyWord, page.toInt());
      search.then((value) {
        setState(() {
          searchRes = value.data;
          res.insertAll(res.length, searchRes.result);
          res.forEach((element) {
            print(element.subject);
          });
        });
      });
    }
  }
}
