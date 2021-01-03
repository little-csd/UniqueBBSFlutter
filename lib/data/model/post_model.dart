import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/data/bean/forum/post_data.dart';
import 'package:UniqueBBS/data/bean/forum/thread_info.dart';
import 'package:UniqueBBS/data/bean/other/attach_data.dart';
import 'package:UniqueBBS/tool/logger.dart';
import 'package:flutter/material.dart';

import '../dio.dart';

/// 管理某个 thread 下所有 post 信息
/// 目前每次重新启动 app 会重新拉取
/// 此 model 的生命周期和创建它的 widget 相同, 不常驻内存
/// Warning: 如果在浏览过程中出现 post 的删除或者添加, 可能会导致并发异常。目前暂不处理
/// 注: post 如果被删除的话，active 会被置 null，另外，后端下发的某些帖子 threadInfo 里的 count
/// 和实际大小不一定对应，甚至还有一些和旧接口不太兼容的东西......
/// TODO: 后续添加数据库层缓存 & 处理浏览帖子的时候帖子被删除的情况
class PostModel extends ChangeNotifier {
  static const _TAG = "PostModel";
  ThreadInfo _threadInfo;
  PostData _firstPost;
  List<AttachData> _attachArr;
  List<PostData> _postData = List();

  bool _fetching = false;
  int _fetchedPage = 0;
  bool _killed = false;
  bool _fetchComplete = false;

  PostModel(this._threadInfo) : assert(_threadInfo != null);

  // 目前 post model 里面存在多少个 post 信息
  int postCount() {
    return _postData.length;
  }

  PostData getFirstPost() {
    if (_firstPost == null) {
      _fetch();
    }
    return _firstPost;
  }

  List<AttachData> getAllAttach() {
    if (_attachArr == null) {
      _fetch();
    }
    return _attachArr;
  }

  // 第几个 item(从零开始计)
  // "我的"帖子信息不要调用此接口!
  PostData getPostData(int index) {
    // 拉取超过范围，正常情况下不会出现
    if (index >= _postData.length) return null;
    // 拿最后一个并且还能拉取，则拉取下一页
    if (index == _postData.length - 1 && !_fetchComplete) {
      _fetch();
    }
    return _postData[index];
  }

  void _fetch() async {
    if (_fetching || _killed || _fetchComplete) return;
    _fetching = true;
    // 拉取下一页
    Logger.v(_TAG, 'fetching page ${_fetchedPage + 1}');
    Server.instance
        .postsInThread(_threadInfo.tid, _fetchedPage + 1)
        .then((rsp) {
      if (rsp.success) {
        _fetchedPage++;
        _fetching = false;
        final data = rsp.data;
        // 此处 group 传的是空值，可能会有影响
        _firstPost = PostData(data.firstPost, data.threadAuthor, [], null);
        _attachArr = data.attachArr;
        _postData.addAll(data.postArr);
        if (data.postArr.length < HyperParam.pageSize) {
          _fetchComplete = true;
        }
        notifyListeners();
      } else {
        Future.delayed(Duration(seconds: HyperParam.requestInterval))
            .then((_) => _fetch());
      }
    });
  }

  // 防止页面丢失后还在不断尝试拉取
  @override
  void dispose() {
    super.dispose();
    _killed = true;
  }
}
