class Logger {
  // 过滤 level 小于 flag 的 log
  static const flag = 2;

  // verbose, flag = 1
  static void v(String tag, String msg) {
    if (flag > 1) return;
    _printLog(tag, msg);
  }

  // debug, flag = 2
  static void d(String tag, String msg) {
    if (flag > 2) return;
    _printLog(tag, msg);
  }

  // info, flag = 3
  static void i(String tag, String msg) {
    if (flag > 3) return;
    _printLog(tag, msg);
  }

  // warning, flag = 4
  static void w(String tag, String msg) {
    if (flag > 4) return;
    _printLog(tag, msg);
  }

  // error, flag = 5
  static void e(String tag, String msg) {
    if (flag > 5) return;
    _printLog(tag, msg);
  }

  static void _printLog(String tag, String msg) {
    final time = DateTime.now();
    print('$time $tag: $msg\n');
  }
}
