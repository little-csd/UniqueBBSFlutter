import 'package:unique_bbs/data/model/avatar_model.dart';
import 'package:unique_bbs/data/model/forum_model.dart';
import 'package:unique_bbs/data/model/thread_model.dart';
import 'package:unique_bbs/tool/logger.dart';

import 'model/user_model.dart';

/// 管理全局数据的单例类
class Repo {
  static const _TAG = "Repo";

  static Repo instance = Repo._internal();

  Repo._internal() {
    Logger.i(_TAG, 'initialized');
  }

  String _localPath = '';

  set localPath(String path) {
    _localPath = path;
    Logger.d(_TAG, 'save local path $path');
  }

  String get localPath => _localPath;

  getPath(String type, String name) => '$_localPath/$type/$name';

  String uid = ''; // 当前用户的 uid
  final UserModel userModel = UserModel();
  final ForumModel forumModel = ForumModel();
  final AvatarModel avatarModel = AvatarModel();

  /// TODO: 这里为了论坛那个界面可以用到 threadModel, 还是把 thread 缓存到内存中了
  /// 后面实现数据库后，就不要在这里 threadModel 了
  final Map<String, ThreadModel> cacheThreadModels = Map();
}
