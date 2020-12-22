import 'dart:collection';

import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/full_forum.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/thread_info.dart';
import 'package:UniqueBBSFlutter/data/bean/user/user_info.dart';
import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:flutter/material.dart';

import '../dio.dart';
import '../repo.dart';

/// 管理某个 Forum 下所有 thread 信息
/// 目前每次重新启动 app 会重新拉取
/// 此 model 的生命周期和创建它的 widget 相同, 不会常驻内存
/// 对于"我的"发帖信息, info 将一直为空!
/// Warning: 如果在浏览过程中出现帖子的删除或者添加, 可能会导致并发异常。目前暂不处理
/// TODO: 后续添加数据库层缓存
class ThreadModel extends ChangeNotifier {
  Map<int, List<ThreadInfo>> _threadMap = HashMap();
  Map<int, List<UserInfo>> _userMap = HashMap();
  List<bool> _fetching;
  FullForum _forum;
  // 不要在外部修改这个变量
  bool isMe;

  ThreadModel(this._forum, this.isMe) : assert(_forum != null) {
    int tot = getPage(_forum.threadCount - 1);
    _fetching = List.filled(tot + 1, false);
  }

  int maxThread() {
    return _forum.threadCount;
  }

  // 第几个 item(从零开始计)
  // "我的"帖子信息不要调用此接口!
  UserInfo getUserInfo(int index) {
    // if (me) return null;
    int page = getPage(index);
    index = index - (page - 1) * HyperParam.pageSize;
    final users = _userMap[page];
    if (users == null) {
      _fetch(page);
      return null;
    }
    // should not happen!!
    if (users.length <= index) {
      return null;
    }
    return users[index];
  }

  ThreadInfo getThreadInfo(int index) {
    int page = getPage(index);
    index = index - (page - 1) * HyperParam.pageSize;
    final threads = _threadMap[page];
    if (threads == null) {
      _fetch(page);
      return null;
    }
    if (threads.length <= index) {
      return null;
    }
    return threads[index];
  }

  void _fetch(int page) async {
    if (page >= _fetching.length || _fetching[page]) return;
    _fetching[page] = true;

    // 我的帖子调用另一个接口获取
    if (isMe) {
      final uid = Repo.instance.uid;
      if (uid == null) {
        return;
      }
      Server.instance.threadsForUser(uid, page).then((rsp) {
        if (rsp.success) {
          _threadMap[page] = rsp.data.threads;
          notifyListeners();
        } else {
          Future.delayed(Duration(seconds: HyperParam.requestInterval))
              .then((_) => _fetch(page));
        }
      });
      return;
    }

    Server.instance.threadsInForum(_forum.fid, page).then((rsp) {
      if (rsp.success) {
        _fetching[page] = false;
        final threads = List<ThreadInfo>(), users = List<UserInfo>();
        rsp.data.threads.forEach((data) {
          threads.add(data.thread);
          users.add(data.user);
        });
        _threadMap[page] = threads;
        _userMap[page] = users;
        notifyListeners();
      } else {
        Future.delayed(Duration(seconds: HyperParam.requestInterval))
            .then((_) => _fetch(page));
      }
    });
  }
}
