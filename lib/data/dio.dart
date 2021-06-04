import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_bbs/config/constant.dart';
import 'package:unique_bbs/data/bean/forum/basic_forum.dart';
import 'package:unique_bbs/data/bean/forum/full_forum.dart';
import 'package:unique_bbs/data/bean/forum/post_list.dart';
import 'package:unique_bbs/data/bean/forum/thread_list.dart';
import 'package:unique_bbs/data/bean/group/group.dart';
import 'package:unique_bbs/data/bean/group/group_users.dart';
import 'package:unique_bbs/data/bean/user/mentee.dart';
import 'package:unique_bbs/data/bean/user/mentor.dart';
import 'package:unique_bbs/data/converter.dart';
import 'package:unique_bbs/tool/helper.dart';
import 'package:unique_bbs/tool/logger.dart';

import 'bean/forum/post_search.dart';
import 'bean/group/group_info.dart';
import 'bean/message/message.dart';
import 'bean/report/reports.dart';
import 'bean/user/user.dart';
import 'bean/user/user_info.dart';
import 'bean/user/user_post.dart';
import 'bean/user/user_thread.dart';
import 'repo.dart';

const _baseUrl = 'https://hustunique.com:7010/api';
Dio dio = Dio(BaseOptions(baseUrl: _baseUrl))
  ..interceptors.add(_LoggingInterceptors());

/// 所有网络请求对应的封装
/// success 表明是否成功
/// 错误时 msg 表示错误信息
/// 成功时 data 表示请求返回的实体
/// 注意 msg 和 data 有一个会是 null
class NetRsp<T> {
  bool success;
  String? msg;
  T? data;

  NetRsp(this.success, {this.msg, this.data});
}

class Server {
  static const _TAG = "Server";
  static const _LoginUrl = '/user/login/pwd';
  static const _UpdateJwt = '/user/update/jwt';

  // user url
  static const _UserUrl = '/user/info';
  static const _MentorUrl = '/user/mentor/info';

  // static const MyMentor = '/user/mentor/my';
  static const _MyMentee = '/user/mentor/students';
  static const _UpdateUser = '/user/update/normal';
  static const _UpdatePwd = '/user/update/pwd';
  static const _UserThreads = '/user/threads';
  static const _UserPosts = '/user/posts';

  // group url
  static const _GroupList = '/group/list';
  static const _GroupUserList = '/group/users';
  static const _UserGroupInfo = '/group/user';

  // report url
  static const _CanPostReport = '/report/can';
  static const _ReportInfo = '/report/info';
  static const _ReportList = '/report/list';
  static const _ReportCreate = '/report/create';
  static const _ReportUpdate = '/report/update';

  // forum url
  static const _ForumList = '/forum/list';
  static const _MiniForumList = '/forum/listSimple';

  // thread / post operation url
  static const _ThreadCreate = '/thread/create';
  static const _ThreadList = '/thread/list';
  static const _ThreadInfo = '/thread/info';
  static const _ThreadReply = '/thread/reply';
  static const _PostUpdate = '/post/update';
  static const _PostSearch = '/post/search';

  // notification url
  static const _MessageList = '/message/list';

  // static const _MessageCount = '/message/count';
  // static const _MessagePush = '/message/push';
  static const _MessageRead = '/message/read';
  static const _MessageDelete = '/message/delete';
  static const _MessageReadAll = '/message/all/read';
  static const _MessageDeleteAll = '/message/all/delete';

  // attach url
  static const _AttachDownload = '/attach/download';

  static const NetworkError = '你的网络好像走丢了\n请试试重新连接吧？';
  static const UserNotFound = '找不到用户信息!';
  static const TokenExpired = 'Token 已过期!';
  static const FormatError = '消息格式错误!';
  static const EmptyMsg = '收到空消息!';
  static const UnknownError = '未知异常';
  static const CodeNotValid = '服务器执行失败';
  static const NoError = '';

  static const _UidKeyInSp = 'uid';
  static const _TokenKeyInSp = 'token';

  VoidCallback? tokenErrCallback = () => {};

  Future<String> init() async {
    // token 过期统一在 _get 和 _post 方法中处理
    final sp = await SharedPreferences.getInstance();
    try {
      String uid = sp.getString(_UidKeyInSp) as String;
      String token = sp.getString(_TokenKeyInSp) as String;
      dio.options.headers[HttpHeaders.authorizationHeader] = token;
      // update token
      Map<String, dynamic> json = HashMap();
      String errno = await _post(_UpdateJwt, {}, json);
      if (errno.isNotEmpty) return errno;
      if (json["code"] != 1) return TokenExpired;
      // save token
      token = json["msg"];
      dio.options.headers[HttpHeaders.authorizationHeader] = token;
      sp
          .setString(_TokenKeyInSp, token)
          .then((value) => Logger.i(_TAG, 'save uid $token $value'));
      Repo.instance.uid = uid;
      return NoError;
    } catch (e) {
      return UserNotFound;
    }
  }

  Future<NetRsp<String>> login(String nickname, String password) async {
    final data = {
      'nickname': nickname,
      'pwd': generateMD5(password),
    };
    Map<String, dynamic> json = HashMap();
    String errno = await _post(_LoginUrl, data, json);
    if (errno.isNotEmpty) {
      return NetRsp(false, msg: errno);
    }
    try {
      Map<String, dynamic> msg = json['msg'];
      String token = msg['token'], uid = msg['uid'];
      dio.options.headers[HttpHeaders.authorizationHeader] = token;
      Repo.instance.uid = uid;
      Logger.d(_TAG, 'token = $token, uid = $uid');
      final sp = await SharedPreferences.getInstance();
      // 此处异步保存
      sp
          .setString(_UidKeyInSp, uid)
          .then((ok) => Logger.i(_TAG, 'save uid $uid $ok'));
      sp
          .setString(_TokenKeyInSp, token)
          .then((value) => Logger.i(_TAG, 'save uid $token $value'));
      return NetRsp(true, data: NoError);
    } catch (e) {
      Logger.e(_TAG, e.toString());
      return NetRsp(false, msg: FormatError);
    }
  }

  void logout() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove(_UidKeyInSp);
    sp.remove(_TokenKeyInSp);
  }

  /// 下面部分为用户相关的 api

  Future<NetRsp<User>> user(String uid) {
    final url = '$_UserUrl/$uid';
    return _process(url, User);
  }

  Future<NetRsp<User>> me() async {
    // should not happen here
    String uid = Repo.instance.uid;
    if (uid.isEmpty) {
      return NetRsp(false, msg: UserNotFound);
    }
    return user(uid);
  }

  /// TODO: 这里会有个问题，恰好下载到一半后退出的话，下次调用时会拿到一个损坏的图像
  Future<NetRsp<Image>> avatar(String path, String savePath) async {
    try {
      path = path.replaceAll(_baseUrl, '');
      Response response = await dio.download(path, savePath);
      if (response.statusCode != HttpStatus.ok) {
        return NetRsp(false, msg: NetworkError);
      }
      final img = Image.file(File(savePath));
      return NetRsp(true, data: img);
    } catch (e) {
      String msg = e.toString();
      Logger.w(_TAG, msg);
      return NetRsp(false, msg: NetworkError);
    }
  }

  Future<NetRsp<void>> attachDownload(String aid, String savePath) async {
    try {
      String token = dio.options.headers[HttpHeaders.authorizationHeader];
      String url = '$_AttachDownload/$aid/$token';
      Response response = await dio.download(url, savePath);
      if (response.statusCode != HttpStatus.ok) {
        return NetRsp(false, msg: NetworkError);
      }
      return NetRsp(true);
    } catch (e) {
      String msg = e.toString();
      Logger.w(_TAG, msg);
      return NetRsp(false, msg: NetworkError);
    }
  }

  Future<NetRsp<Mentor>> mentor(String uid) {
    final url = '$_MentorUrl/$uid';
    return _process(url, Mentor);
  }

  Future<NetRsp<Mentor>> myMentor() async {
    String uid = Repo.instance.uid;
    if (uid.isEmpty) {
      return NetRsp(false, msg: UserNotFound);
    }
    return mentor(uid);
  }

  Future<NetRsp<Mentee>> myMentee() {
    return _process(_MyMentee, Mentee);
  }

  Future<NetRsp<void>> updateUser(UserInfo user) {
    final req = {
      'studentID': user.studentID,
      'dormitory': user.dormitory,
      'qq': user.qq,
      'wechat': user.wechat,
      'major': user.major,
      'className': user.className,
      'nickname': user.username,
      'signature': user.signature
    };
    return _processRaw(_UpdateUser, Null, req: req);
  }

  Future<NetRsp<void>> updatePwd(String oldPwd, String newPwd) {
    final req = {
      'previousPwd': generateMD5(oldPwd),
      'newPwd': generateMD5(newPwd),
    };
    return _processRaw(_UpdatePwd, Null, req: req);
  }

  Future<NetRsp<UserThread>> threadsForUser(String uid, int page) {
    final url = '$_UserThreads/$uid/$page';
    return _process(url, UserThread);
  }

  Future<NetRsp<UserPost>> postForUser(String uid, int page) {
    final url = '$_UserPosts/$uid/$page';
    return _process(url, UserPost);
  }

  /// 下面为组别信息的请求

  Future<NetRsp<List<Group>>> groups() {
    return _processArray(_GroupList, Group);
  }

  Future<NetRsp<GroupUsers>> groupUsers(String gid) {
    final url = '$_GroupUserList/$gid';
    return _process(url, GroupUsers);
  }

  Future<NetRsp<List<GroupInfo>>> groupInfo(String uid) {
    final url = '$_UserGroupInfo/$uid';
    return _processArray(url, GroupInfo);
  }

  /// 下面开始是日报/周报部分

  Future<NetRsp<List<bool>>> canReport() async {
    Map<String, dynamic> json = HashMap();
    final errno = await _get(_CanPostReport, json);
    if (errno.isNotEmpty) {
      return NetRsp(false, msg: errno);
    }
    try {
      Map<String, dynamic> msg = json['msg'];
      bool weekly = msg['weekly'];
      bool daily = msg['daily'];
      return NetRsp(true, data: [weekly, daily]);
    } catch (e) {
      Logger.e(_TAG, e.toString());
      return NetRsp(false, msg: FormatError);
    }
  }

  Future<NetRsp<String>> reportInfo(String rid) {
    final url = '$_ReportInfo/$rid';
    return _processRaw(url, String, req: {});
  }

  Future<NetRsp<Reports>> reports(String uid, int page) {
    final url = '$_ReportList/$uid/$page';
    return _process(url, Reports);
  }

  Future<NetRsp<String>> createReport(bool weekly, String msg) {
    final req = {
      'isWeekReport': weekly ? "1" : "0",
      'message': msg,
    };
    return _processRaw(_ReportCreate, String, req: req);
  }

  Future<NetRsp<void>> updateReport(String rid, String msg) {
    final req = {
      'message': msg,
    };
    return _processRaw('$_ReportUpdate/$rid', Null, req: req);
  }

  /// 下面部分为论坛/帖子/回复相关的 api

  Future<NetRsp<List<FullForum>>> forums() {
    return _processArray(_ForumList, FullForum);
  }

  Future<NetRsp<List<BasicForum>>> basicForums() {
    return _processArray(_MiniForumList, BasicForum);
  }

  Future<NetRsp<String>> threadCreate(
      String fid, String subject, String msg, List<String> fileListArr) {
    final req = {
      'fid': fid,
      'subject': subject,
      'message': msg,
      'fileListArr': fileListArr,
    };
    return _processRaw(_ThreadCreate, String, req: req);
  }

  Future<NetRsp<ThreadList>> threadsInForum(String fid, int page) {
    final url = '$_ThreadList/$fid/$page';
    return _process(url, ThreadList);
  }

  Future<NetRsp<PostList>> postsInThread(String tid, int page) {
    final url = '$_ThreadInfo/$tid/$page';
    return _process(url, PostList);
  }

  Future<NetRsp<void>> replyUpdate(String pid, String msg) {
    final req = {
      'message': msg,
    };
    return _processRaw('$_PostUpdate/$pid', Null, req: req);
  }

  Future<NetRsp<void>> threadReply(String tid, String msg, String quote) {
    final req = {
      'tid': tid,
      'message': msg,
      'quote': quote,
    };
    return _processRaw(_ThreadReply, Null, req: req);
  }

  Future<NetRsp<PostSearch>> postSearch(String keyword, int page) {
    final req = {
      'keyword': keyword,
    };
    final url = '$_PostSearch/$page';
    return _process(url, PostSearch, req: req);
  }

  /// 下面是通知相关的 api
  Future<NetRsp<List<Message>>> messages(int page) {
    final url = '$_MessageList/$page';
    return _processArray(url, Message);
  }

  Future<NetRsp<void>> read(String mid) {
    final url = '$_MessageRead/$mid';
    return _processRaw(url, Null, req: {});
  }

  Future<NetRsp<void>> delete(String mid) {
    final url = '$_MessageDelete/$mid';
    return _processRaw(url, Null, req: {});
  }

  Future<NetRsp<void>> readAll() {
    return _processRaw(_MessageReadAll, Null, req: {});
  }

  Future<NetRsp<void>> deleteAll() {
    return _processRaw(_MessageDeleteAll, Null, req: {});
  }

  /// 下面开始是内部使用的辅助方法

  // 处理请求, 返回带有原始类型(int, string 等)的 NetRsp, 存于 data 字段
  // 若请求失败, 则错误信息存放在 msg 字段
  Future<NetRsp<T>> _processRaw<T>(
    String url,
    Type type, {
    Map<String, dynamic>? req,
  }) async {
    Map<String, dynamic> json = HashMap();
    // validate for network request
    String errno;
    if (req == null) {
      errno = await _get(url, json);
    } else {
      errno = await _post(url, req, json);
    }
    if (errno.isNotEmpty) {
      return NetRsp(false, msg: errno);
    }
    // validate for 'msg' field
    try {
      T msg = json['msg'];
      return NetRsp(true, data: msg);
    } catch (e) {
      Logger.e(_TAG, e.toString());
      return NetRsp(false, msg: FormatError);
    }
  }

  // 处理请求, 返回带有类型为 type 的 NetRsp, 存于 data 字段
  // 若请求失败, 则错误信息存放在 msg 字段
  Future<NetRsp<T>> _process<T>(
    String url,
    Type type, {
    Map<String, dynamic>? req,
  }) async {
    Map<String, dynamic> json = HashMap();
    // validate for network request
    String errno;
    if (req == null) {
      errno = await _get(url, json);
    } else {
      errno = await _post(url, req, json);
    }
    if (errno.isNotEmpty) {
      return NetRsp(false, msg: errno);
    }
    // validate for 'msg' field & converter
    try {
      final data = Converter.getFromJson(type, json['msg']);
      return NetRsp(true, data: data);
    } catch (e) {
      Logger.e(_TAG, e.toString());
      return NetRsp(false, msg: FormatError);
    }
  }

  // 处理请求, 返回带有类型为 type 的 List 的 NetRsp, 存于 data 字段
  // 若请求失败, 则错误信息存放在 msg 字段
  Future<NetRsp<List<T>>> _processArray<T>(
    String url,
    Type type, {
    Map<String, dynamic>? req,
  }) async {
    Map<String, dynamic> json = HashMap();
    // validate for network request
    String errno;
    if (req == null) {
      errno = await _get(url, json);
    } else {
      errno = await _post(url, req, json);
    }
    if (errno.isNotEmpty) {
      return NetRsp(false, msg: errno);
    }
    // validate for 'msg' field
    List? msg = json['msg'];
    if (msg == null) {
      return NetRsp(false, msg: EmptyMsg);
    }
    if (msg.length == 0) {
      return NetRsp(true, data: []);
    } else {
      // validate for converter
      try {
        final data = <T>[];
        for (var value in msg) {
          data.add(Converter.getFromJson(type, value as Map<String, dynamic>));
        }
        return NetRsp(true, data: data);
      } catch (e) {
        Logger.e(_TAG, e.toString());
        return NetRsp(false, msg: FormatError);
      }
    }
  }

  // 发送 Post 请求, 没有错误则返回 null, 并将数据填充到 json 这个 map 中
  // 若有错误则返回错误信息
  Future<String> _post(
      String url, dynamic data, Map<String, dynamic> json) async {
    try {
      Logger.d(_TAG, "before $url");
      Response response = await dio.post(url, data: data);
      Logger.d(_TAG, "after $url");
      Map<String, dynamic> res = response.data;
      int code = res['code'];
      if (code == 1) {
        json.addAll(res);
        return '';
      } else {
        String msg = res['msg'] ?? "";
        if (msg == StringConstant.jwtExpired ||
            msg == StringConstant.jwtMalformed) {
          tokenErrCallback?.call();
        }
        return msg;
      }
    } catch (e) {
      // may be token expired or server error occurred
      String msg = e.toString();
      Logger.w(_TAG, msg);
      return NetworkError;
    }
  }

  // 发送 Get 请求, 没有错误则返回空字符串, 并将结果填充到 json 这个 map 中
  // 若有错误则返回错误信息
  Future<String> _get(String url, Map<String, dynamic> json) async {
    try {
      Response response = await dio.get(url);
      Map<String, dynamic> res = response.data;
      int code = res['code'];
      if (code == 1) {
        json.addAll(res);
        return '';
      } else {
        String msg = res['msg'] ?? "";
        if (msg == StringConstant.jwtExpired ||
            msg == StringConstant.jwtMalformed) {
          tokenErrCallback?.call();
        }
        return msg;
      }
    } catch (e) {
      // may be token expired or server error occurred
      String msg = e.toString();
      Logger.w(_TAG, msg);
      return NetworkError;
    }
  }

  /// 下面部分为单例的构造
  Server._internal() {
    Logger.i(_TAG, 'initialized');
  }

  static Server instance = Server._internal();
}

class _LoggingInterceptors extends Interceptor {
  static const _TAG = "LoggingInterceptors";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.d(_TAG,
        "--> ${options.method.toUpperCase()} ${options.baseUrl + options.path}");
    Logger.d(_TAG, "Headers:");
    options.headers.forEach((k, v) => Logger.d(_TAG, '$k: $v'));

    Logger.d(_TAG, "queryParameters:");
    options.queryParameters.forEach((k, v) => Logger.d(_TAG, '$k: $v'));

    if (options.data != null) {
      Logger.d(_TAG, "Body: ${options.data}");
    }
    Logger.d(_TAG, "--> END ${options.method.toUpperCase()}");

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final String url =
        response.requestOptions.baseUrl + response.requestOptions.path;
    Logger.d(_TAG, "<-- ${response.statusCode} $url");
    Logger.d(_TAG, "Headers:");
    response.headers.forEach((k, v) => Logger.d(_TAG, '$k: $v'));
    Logger.d(_TAG, "Response: ${response.data}");
    Logger.d(_TAG, "<-- END HTTP");

    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var response = err.response;
    if (response != null) {
      String url =
          response.requestOptions.baseUrl + response.requestOptions.path;
      Logger.d(_TAG, "<-- ${err.message} $url");
      Logger.d(_TAG, "Error Response: ${response.data}");
    } else {
      Logger.d(_TAG, "<-- ${err.message}");
    }

    Logger.d(_TAG, "<-- End error");

    handler.next(err);
  }
}
