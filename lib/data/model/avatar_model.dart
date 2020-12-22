import 'dart:collection';
import 'dart:io';

import 'package:UniqueBBSFlutter/tool/logger.dart';
import 'package:flutter/material.dart';

import '../dio.dart';
import '../repo.dart';

class AvatarModel extends ChangeNotifier {
  static const _TAG = "AvatarModel";
  Map<String, Image> _avatarMap = HashMap();
  Set<String> _pendingSet = HashSet();
  static const _retryInterval = 5;

  void doNotify() async {
    notifyListeners();
  }

  void _put(String name, Image img) {
    if (img == null) {
      Logger.w(_TAG, 'Put a null img for $name');
      return;
    }
    _avatarMap[name] = img;
    notifyListeners();
  }

  Image find(String path) {
    final name = path.split('/').last;
    Image image = _avatarMap[name];
    if (image == null) {
      image = _findInLocal(path, name);
    }
    return image;
  }

  Image _findInLocal(String url, String name) {
    final savePath = '${Repo.instance.localPath}/$name';
    final file = File(savePath);
    if (file.existsSync()) {
      final image = Image.file(file);
      if (image != null) {
        _avatarMap[name] = image;
        return image;
      }
    }
    _findInNetwork(url, savePath, name);
    return null;
  }

  void _findInNetwork(String url, String savePath, String name) async {
    if (_pendingSet.contains(name)) return;
    _pendingSet.add(name);
    Server.instance.avatar(url, savePath).then((rsp) {
      if (rsp.success) {
        _pendingSet.remove(name);
        _put(name, rsp.data);
      } else {
        Future.delayed(Duration(seconds: _retryInterval))
            .then((_) => _findInNetwork(url, savePath, name));
      }
    });
  }
}
