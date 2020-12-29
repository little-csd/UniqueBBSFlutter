import 'dart:collection';

import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/post_data.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/thread_info.dart';
import 'package:UniqueBBSFlutter/data/bean/other/attach_data.dart';
import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:flutter/material.dart';

import '../dio.dart';

/// 管理某个 thread 下所有 post 信息
/// 目前每次重新启动 app 会重新拉取
/// 此 model 的生命周期和创建它的 widget 相同, 不会常驻内存
/// Warning: 如果在浏览过程中出现 post 的删除或者添加, 可能会导致并发异常。目前暂不处理
/// TODO: 后续添加数据库层缓存
class PostModel extends ChangeNotifier {
  ThreadInfo _thread;
  PostData _firstPost;
  List<AttachData> _attachArr;
  Map<int, List<PostData>> _postMap = HashMap();
  List<bool> _fetching;

  PostModel(this._thread) : assert(_thread != null) {
    int tot = getPage(_thread.postCount - 1);
    _fetching = List.filled(tot + 1, false);
  }

  // 包含 threadAuthor 在内的总 post 的个数
  int maxCount() {
    return _thread.postCount;
  }

  PostData getFirstPost() {
    if (_firstPost == null) {
      _fetch(1);
    }
    return _firstPost;
  }

  List<AttachData> getAllAttach() {
    if (_attachArr == null) {
      _fetch(1);
    }
    return _attachArr;
  }

  // 第几个 item(从零开始计)
  // "我的"帖子信息不要调用此接口!
  PostData getPostData(int index) {
    int page = getPage(index);
    index = index - (page - 1) * HyperParam.pageSize;
    final data = _postMap[page];
    if (data == null) {
      _fetch(page);
      return null;
    }
    if (data.length <= index) {
      return null;
    }
    return data[index];
  }

  void _fetch(int page) async {
    if (page >= _fetching.length || _fetching[page]) return;
    _fetching[page] = true;

    Server.instance.postsInThread(_thread.tid, page).then((rsp) {
      if (rsp.success) {
        _fetching[page] = false;
        final data = rsp.data;
        // TODO: 此处 group 传的是空值，可能会有影响
        _firstPost = PostData(
            data.firstPost, data.threadAuthor, [], StringConstant.noQuote);
        _attachArr = data.attachArr;
        _postMap[page] = data.postArr;
        notifyListeners();
      } else {
        Future.delayed(Duration(seconds: HyperParam.requestInterval))
            .then((_) => _fetch(page));
      }
    });
  }
}
