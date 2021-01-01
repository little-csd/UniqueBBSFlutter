import 'dart:collection';
import 'dart:io';

import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/tool/logger.dart';
import 'package:flutter/material.dart';

import '../dio.dart';
import '../repo.dart';

/// TODO: 读取某个 image 时做采样处理，防止头像占用过多内存空间
class AvatarModel extends ChangeNotifier {
  static const _TAG = "AvatarModel";
  Map<String, Image> _avatarMap = HashMap();
  Set<String> _pendingSet = HashSet();

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

    /// 这里判断 pendingSet 是防止下载中还去读取文件，导致读取异常
    if (image == null && !_pendingSet.contains(name)) {
      image = _findInLocal(path, name);
    }
    return image;
  }

  void refresh(String url) {
    final name = url.split('/').last;
    final savePath = '${Repo.instance.localPath}/$name';
    _findInNetwork(url, savePath, name);
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
        Future.delayed(Duration(seconds: HyperParam.requestInterval))
            .then((_) => _findInNetwork(url, savePath, name));
      }
    });
  }
}
