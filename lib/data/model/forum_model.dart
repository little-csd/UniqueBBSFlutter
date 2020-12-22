import 'package:UniqueBBSFlutter/data/bean/forum/full_forum.dart';
import 'package:flutter/material.dart';

import '../dio.dart';

/// 管理所有 forum 信息
/// 目前每次重新启动 app 会重新拉取
/// 只做了简单的防止重复拉取操作
/// TODO: 后续添加数据库层缓存
class ForumModel extends ChangeNotifier {
  List<FullForum> _forums;
  bool _fetching = false;
  static const _fetchInterval = 5;

  FullForum findByName(String name) {
    if (_forums == null) {
      _fetch();
      return null;
    }
    for (final forum in _forums) {
      if (forum.name == name) {
        return forum;
      }
    }
    return null;
  }

  List<FullForum> getAll() {
    if (_forums == null) _fetch();
    return _forums;
  }

  void _fetch() async {
    if (_fetching) return;
    _fetching = true;
    Server.instance.forums().then((rsp) {
      if (rsp.success) {
        _fetching = false;
        _forums = rsp.data;
        notifyListeners();
      } else {
        Future.delayed(Duration(seconds: _fetchInterval)).then((_) => _fetch());
      }
    });
  }
}
