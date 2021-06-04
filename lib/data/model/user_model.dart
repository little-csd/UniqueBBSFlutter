import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:unique_bbs/data/bean/user/user.dart';

import '../dio.dart';

const _reqInterval = 5;

/// 管理 user 的所有信息
/// 使用 dio.dart 中的接口 user(uid) 获取
class UserModel extends ChangeNotifier {
  static const _TAG = "UserModel";
  Map<String, User> _userMap = HashMap();

  void put(String uid, User user) {
    _userMap[uid] = user;
    notifyListeners();
  }

  void putAll(Map<String, User> newData) {
    _userMap.addAll(newData);
    notifyListeners();
  }

  User? find(String uid) {
    final User? user = _userMap[uid];
    if (user == null) {
      pull(uid);
    }
    return user;
  }

  void pull(String uid) {
    if (_userMap[uid] != null) {
      return;
    }
    Server.instance.user(uid).then((rsp) {
      if (rsp.success) {
        final data = rsp.data;
        if (data != null) {
          put(uid, data);
        }
      } else {
        Future.delayed(Duration(seconds: _reqInterval)).then((_) => pull(uid));
      }
    });
  }

  void clearAll() {
    _userMap.clear();
    notifyListeners();
  }
}
