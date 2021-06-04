import 'package:flutter/material.dart';
import 'package:unique_bbs/config/constant.dart';
import 'package:unique_bbs/data/bean/forum/full_forum.dart';
import 'package:unique_bbs/data/bean/forum/thread_info.dart';
import 'package:unique_bbs/data/bean/user/user_info.dart';
import 'package:unique_bbs/tool/logger.dart';

import '../dio.dart';
import '../repo.dart';

/// 管理某个 Forum 下所有 thread 信息
/// 目前每次重新启动 app 会重新拉取
/// 此 model 的生命周期和创建它的 widget 相同, 不会常驻内存
/// 对于"我的"发帖信息, info 将一直为空!
/// Warning: 如果在浏览过程中出现帖子的删除或者添加, 可能会导致并发异常。目前暂不处理
/// TODO: 后续添加数据库层缓存
class ThreadModel extends ChangeNotifier {
  static const _TAG = "ThreadModel";
  List<ThreadInfo> _threadList = List();
  List<UserInfo> _userList = List();

  int _fetchedPage = 0;
  bool _fetching = false;
  bool _fetchComplete = false;
  FullForum _forum;
  bool _killed = false;

  // 不要在外部修改这个变量
  bool isMe;

  ThreadModel(this._forum, {this.isMe = false})
      : assert(_forum != null || isMe);

  get threadCount => _threadList.length;

  // 第几个 item(从零开始计)
  // "我的"帖子信息不要调用此接口!
  UserInfo getUserInfo(int index) {
    if (isMe) return Repo.instance.me?.user;
    if (index >= _userList.length) return null;
    return _userList[index];
  }

  ThreadInfo getThreadInfo(int index) {
    if (index >= _threadList.length) return null;
    return _threadList[index];
  }

  /// Thread model 这里 fetch 方法暴露给外部，在 ui 界面可以自行确定拉取逻辑
  void fetch() async {
    if (_fetching || _killed || _fetchComplete) return;
    _fetching = true;
    Logger.v(_TAG, "Fetching page ${_fetchedPage + 1}");
    // 我的帖子调用另一个接口获取
    if (isMe)
      _fetchUserThreads();
    else
      _fetchForumThreads();
  }

  void _fetchUserThreads() {
    final uid = Repo.instance.uid;
    Server.instance.threadsForUser(uid, _fetchedPage + 1).then((rsp) {
      if (rsp.success) {
        _threadList.addAll(rsp.data.threads);
        if (rsp.data.threads.length < HyperParam.pageSize) {
          _fetchComplete = true;
        }
        _onFetchedSuccess();
      } else {
        Future.delayed(Duration(seconds: HyperParam.requestInterval))
            .then((_) => fetch());
      }
    });
  }

  void _fetchForumThreads() {
    Server.instance.threadsInForum(_forum.fid, _fetchedPage + 1).then((rsp) {
      if (rsp.success) {
        final threads = List<ThreadInfo>(), users = List<UserInfo>();
        rsp.data.threads.forEach((data) {
          threads.add(data.thread);
          users.add(data.user);
        });
        if (rsp.data.threads.length < HyperParam.pageSize) {
          _fetchComplete = true;
        }
        _threadList.addAll(threads);
        _userList.addAll(users);
        _onFetchedSuccess();
      } else {
        Future.delayed(Duration(seconds: HyperParam.requestInterval))
            .then((_) => fetch());
      }
    });
  }

  void _onFetchedSuccess() {
    _fetching = false;
    _fetchedPage++;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _killed = true;
  }
}
