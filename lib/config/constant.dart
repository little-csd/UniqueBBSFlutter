import 'dart:ui';

// 颜色相关的资源常量
class ColorConstant {
  static const backgroundGray = Color(0xfffafafa);
  static const backgroundWhite = Color(0xffffffff);
  static const borderGray = Color(0xffe6e6e6);
  static const textGray = Color(0xff999999);
  static const primaryColor = Color(0xff7966FF);
  static const primaryColorLight = Color(0xFFFFDFFD);
  static const accentColor = Color(0xff555555);
  static const skyButtonGray = Color(0xff707070);
  static const skyInputPurple = Color(0xfff0f0f6);
  static const skyInputHintPurple = Color(0xffcecae7);

}

// 字符串相关的资源常量
class StringConstant {
  static final info = '情报';
  static final forum = '论坛';
  static final home = '首页';
  static final me = '我的';
  static final edit = '编辑';
  static final delete = '删除';
  static final newComment = '最新评论';
}

class SvgIcon {
  static final _base = 'images/';

  static final notification = _base + 'notification.svg';
  static final message = _base + 'message.svg';
  static final person = _base + 'person.svg';
  static final search = _base + 'search.svg';
  static final file = _base + 'file.svg';
  static final freshmanTask = _base + 'freshman_task.svg';
  static final projectTask = _base + 'project_task.svg';
  static final share = _base + 'share.svg';
}
