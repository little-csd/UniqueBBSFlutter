import 'dart:collection';

import 'package:UniqueBBSFlutter/tool/logger.dart';
import 'package:flutter/material.dart';

class AvatarModel extends ChangeNotifier {
  static const _TAG = "AvatarModel";
  Map<String, Image> _avatarMap = HashMap();

  void put(String name, Image img) {
    if (img == null) {
      Logger.w(_TAG, 'Put a null img for $name');
      return;
    }
    _avatarMap[name] = img;
    notifyListeners();
  }

  Image find(String name) {
    return _avatarMap[name];
  }
}
