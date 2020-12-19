import 'package:UniqueBBSFlutter/data/model/avatar_model.dart';
import 'package:UniqueBBSFlutter/data/model/forum_model.dart';
import 'package:UniqueBBSFlutter/tool/logger.dart';

import 'model/user_model.dart';

/// 管理全局数据的单例类, 初始化非线程安全!
class Repo {
  static const _TAG = "Repo";

  factory Repo() => _getInstance();
  static Repo get instance => _getInstance();
  Repo._internal() {
    Logger.i(_TAG, 'initialized');
  }

  static Repo _instance;
  static Repo _getInstance() {
    if (_instance == null) {
      _instance = Repo._internal();
    }
    return _instance;
  }

  String uid = ''; // 当前用户的 uid
  final UserModel userModel = UserModel();
  final ForumModel threadModel = ForumModel();
  final AvatarModel avatarModel = AvatarModel();
}
