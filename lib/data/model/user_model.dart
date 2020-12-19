import 'dart:collection';

import 'package:UniqueBBSFlutter/data/bean/user.dart';
import 'package:UniqueBBSFlutter/tool/logger.dart';
import 'package:flutter/material.dart';

/// 管理 user 的所有信息
/// 使用 dio.dart 中的接口 user(uid) 获取
class UserModel extends ChangeNotifier {
  static const _TAG = "UserModel";
  Map<String, User> _userMap = HashMap();

  void put(String uid, User user) {
    if (user == null) {
      Logger.w(_TAG, 'Put a null user for uid: $uid');
      return;
    }
    _userMap[uid] = user;
    notifyListeners();
  }

  void putAll(Map<String, User> newData) {
    _userMap.addAll(newData);
    notifyListeners();
  }

  User find(String uid) {
    return _userMap[uid];
  }

  void clearAll() {
    _userMap.clear();
    notifyListeners();
  }
}
