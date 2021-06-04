import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unique_bbs/config/constant.dart';

import '../dio.dart';
import '../repo.dart';

/// TODO: 读取某个 image 时做采样处理，防止头像占用过多内存空间
class AvatarModel extends ChangeNotifier {
  static const _TAG = "AvatarModel";
  static const _avatarType = 'avatar';
  Map<String, Image> _avatarMap = HashMap();
  Set<String> _pendingSet = HashSet();

  void _put(String name, Image img) {
    _avatarMap[name] = img;
    notifyListeners();
  }

  Image? find(String path) {
    final name = path.split('/').last;
    Image? image = _avatarMap[name];

    /// 这里判断 pendingSet 是防止下载中还去读取文件，导致读取异常
    if (image == null && !_pendingSet.contains(name)) {
      image = _findInLocal(path, name);
    }
    return image;
  }

  void refresh(String url) {
    final name = url.split('/').last;
    final savePath = Repo.instance.getPath(_avatarType, name);
    _findInNetwork(url, savePath, name);
  }

  Image? _findInLocal(String url, String name) {
    // TODO: 更改保存的目录
    final savePath = Repo.instance.getPath(_avatarType, name);
    final file = File(savePath);
    if (file.existsSync()) {
      final image = Image.file(file);
      _avatarMap[name] = image;
      return image;
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
        final data = rsp.data;
        if (data != null) {
          _put(name, data);
        }
      } else {
        Future.delayed(Duration(seconds: HyperParam.requestInterval))
            .then((_) => _findInNetwork(url, savePath, name));
      }
    });
  }
}
