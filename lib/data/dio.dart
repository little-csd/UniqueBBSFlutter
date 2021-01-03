import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui';

import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/data/bean/forum/basic_forum.dart';
import 'package:UniqueBBS/data/bean/forum/full_forum.dart';
import 'package:UniqueBBS/data/bean/forum/post_list.dart';
import 'package:UniqueBBS/data/bean/forum/thread_list.dart';
import 'package:UniqueBBS/data/bean/group/group.dart';
import 'package:UniqueBBS/data/bean/group/group_users.dart';
import 'package:UniqueBBS/data/bean/user/mentee.dart';
import 'package:UniqueBBS/data/bean/user/mentor.dart';
import 'package:UniqueBBS/data/converter.dart';
import 'package:UniqueBBS/tool/helper.dart';
import 'package:UniqueBBS/tool/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String msg;
  T data;

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

  static const NetworkError = '你的网络好像走丢了\n请试试重新连接吧？';
  static const UidError = '找不到用户信息!';
  static const TokenExpired = 'Token 已过期!';
  static const EmptyMsg = '收到空消息!';
  static const UnknownError = '未知异常';
  static const CodeNotValid = '服务器执行失败';
  static const NoError = '';

  static const _UidKeyInSp = 'uid';
  static const _TokenKeyInSp = 'token';

  VoidCallback tokenErrCallback = () => {};

  Future<String> init() async {
    // token 过期统一在 _get 和 _post 方法中处理
    final sp = await SharedPreferences.getInstance();
    String uid = sp.getString(_UidKeyInSp);
    String token = sp.getString(_TokenKeyInSp);
    Logger.d(_TAG, 'token = $token, uid = $uid');
    if (uid == null || token == null) {
      return UidError;
    }
    dio.options.headers[HttpHeaders.authorizationHeader] = token;
    // update token
    Map<String, dynamic> json = HashMap();
    String errno = await _post(_UpdateJwt, {}, json);
    if (errno != null) return errno;
    if (json["code"] != 1) return TokenExpired;
    // save token
    token = json["msg"];
    dio.options.headers[HttpHeaders.authorizationHeader] = token;
    sp
        .setString(_TokenKeyInSp, token)
        .then((value) => Logger.i(_TAG, 'save uid $token $value'));
    Repo.instance.uid = uid;
    return NoError;
  }

  Future<NetRsp<String>> login(String nickname, String password) async {
    final data = {
      'nickname': nickname,
      'pwd': generateMD5(password),
    };
    Map<String, dynamic> json = HashMap();
    String errno = await _post(_LoginUrl, data, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    Map<String, dynamic> msg = json['msg'];
    if (msg == null) {
      return NetRsp(false, msg: EmptyMsg);
    }
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
      return NetRsp(false, msg: UidError);
    }
    return user(uid);
  }

  Future<NetRsp<Image>> avatar(String path, String savePath) async {
    try {
      path = path.replaceAll(_baseUrl, '');
      Response response = await dio.download(path, savePath);
      if (response.statusCode != HttpStatus.ok) {
        return NetRsp(false, msg: NetworkError);
      }
      final img = Image.file(File(savePath));
      if (img == null) {
        return NetRsp(false, msg: UnknownError);
      }
      return NetRsp(true, data: img);
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
      return NetRsp(false, msg: UidError);
    }
    return mentor(uid);
  }

  Future<NetRsp<Mentee>> myMentee() {
    return _process(_MyMentee, Mentee);
  }

  Future<NetRsp<bool>> updateUser(UserInfo user) async {
    final req = {
      'studentId': user.studentID,
      'dormitory': user.dormitory,
      'qq': user.qq,
      'wechat': user.wechat,
      'major': user.major,
      'className': user.className,
      'nickname': user.username,
      'signature': user.signature
    };
    return _simplePost(_UpdateUser, req);
  }

  Future<NetRsp<bool>> updatePwd(String oldPwd, String newPwd) async {
    final req = {
      'previousPwd': generateMD5(oldPwd),
      'newPwd': generateMD5(newPwd),
    };
    return _simplePost(_UpdatePwd, req);
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
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    Map<String, dynamic> msg = json['msg'];
    if (msg == null) {
      return NetRsp(false, msg: EmptyMsg);
    }
    return NetRsp(true, data: [msg['weekly'] as bool, msg['daily'] as bool]);
  }

  Future<NetRsp<String>> reportInfo(String rid) async {
    final url = '$_ReportInfo/$rid';
    Map<String, dynamic> json = HashMap();
    final errno = await _get(url, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    String msg = json['msg'];
    if (msg == null) {
      return NetRsp(false, msg: EmptyMsg);
    }
    return NetRsp(true, data: msg);
  }

  Future<NetRsp<Reports>> reports(String uid, int page) {
    final url = '$_ReportList/$uid/$page';
    return _process(url, Reports);
  }

  Future<NetRsp<String>> createReport(bool weekly, String msg) async {
    final req = {
      'isWeekReport': weekly ? "1" : "0",
      'message': msg,
    };
    Map<String, dynamic> json = HashMap();
    final errno = await _post(_ReportCreate, req, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    return NetRsp(true, data: json["msg"] as String);
  }

  Future<NetRsp<bool>> updateReport(String rid, String msg) async {
    final req = {
      'message': msg,
    };
    return _simplePost('$_ReportUpdate/$rid', req);
  }

  /// 下面部分为论坛/帖子/回复相关的 api

  Future<NetRsp<List<FullForum>>> forums() {
    return _processArray(_ForumList, FullForum);
  }

  Future<NetRsp<List<BasicForum>>> basicForums() {
    return _processArray(_MiniForumList, BasicForum);
  }

  Future<NetRsp<String>> threadCreate(
      String fid, String subject, String msg, List<String> fileListArr) async {
    final req = {
      'fid': fid,
      'subject': subject,
      'message': msg,
      'fileListArr': fileListArr,
    };
    Map<String, dynamic> json = HashMap();
    final errno = await _post(_ThreadCreate, req, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    String tid = json["msg"];
    if (null == tid) {
      return NetRsp(false, msg: UnknownError);
    }
    return NetRsp(true, data: tid);
  }

  Future<NetRsp<ThreadList>> threadsInForum(String fid, int page) {
    final url = '$_ThreadList/$fid/$page';
    return _process(url, ThreadList);
  }

  Future<NetRsp<PostList>> postsInThread(String tid, int page) {
    final url = '$_ThreadInfo/$tid/$page';
    return _process(url, PostList);
  }

  Future<NetRsp<bool>> replyUpdate(String pid, String msg) {
    final req = {
      'message': msg,
    };
    return _simplePost('$_PostUpdate/$pid', req);
  }

  Future<NetRsp<bool>> threadReply(String tid, String msg, String quote) {
    final req = {
      'tid': tid,
      'message': msg,
      'quote': quote,
    };
    return _simplePost('$_ThreadReply', req);
  }

  Future<NetRsp<PostSearch>> postSearch(String keyword, int page) async {
    final req = {
      'keyword': keyword,
    };
    final url = '$_PostSearch/$page';
    Map<String, dynamic> json = HashMap();
    final errno = await _post(url, req, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    Map<String, dynamic> msg = json['msg'];
    if (msg == null) {
      return NetRsp(false, msg: EmptyMsg);
    }
    final data = Converter.getFromJson(PostSearch, msg);
    return NetRsp(true, data: data);
  }

  /// 下面是通知相关的 api
  Future<NetRsp<List<Message>>> messages(int page) {
    final url = '$_MessageList/$page';
    return _processArray(url, Message);
  }

  Future<NetRsp<bool>> read(String mid) {
    final url = '$_MessageRead/$mid';
    return _simplePost(url, {});
  }

  Future<NetRsp<bool>> delete(String mid) {
    final url = '$_MessageDelete/$mid';
    return _simplePost(url, {});
  }

  Future<NetRsp<bool>> readAll() {
    return _simplePost(_MessageReadAll, {});
  }

  Future<NetRsp<bool>> deleteAll() {
    return _simplePost(_MessageDeleteAll, {});
  }

  /// 下面开始是内部使用的辅助方法

  // 处理一个 get 请求, 返回带有类型为 type 的 NetRsp, 存于 data 字段
  // 若请求失败, 则错误信息存放在 msg 字段
  Future<NetRsp<T>> _process<T>(String url, Type type) async {
    Map<String, dynamic> json = HashMap();
    final errno = await _get(url, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    Map<String, dynamic> msg = json['msg'];
    if (msg == null) {
      return NetRsp(false, msg: EmptyMsg);
    }
    final data = Converter.getFromJson(type, msg);
    return NetRsp(true, data: data);
  }

  // 处理一个 get 请求, 返回带有类型为 type 的 List 的 NetRsp, 存于 data 字段
  // 若请求失败, 则错误信息存放在 msg 字段
  Future<NetRsp<List<T>>> _processArray<T>(String url, Type type) async {
    Map<String, dynamic> json = HashMap();
    final errno = await _get(url, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    List msg = json['msg'];
    if (msg == null) {
      return NetRsp(false, msg: EmptyMsg);
    }
    if (msg.length == 0) {
      return NetRsp(true, data: []);
    } else {
      final data = List<T>();
      for (var value in msg) {
        data.add(Converter.getFromJson(type, value as Map));
      }
      return NetRsp(true, data: data);
    }
  }

  // 发送仅返回一个 code 的 post 请求
  Future<NetRsp<bool>> _simplePost(String url, Map<String, dynamic> req) async {
    Map<String, dynamic> json = HashMap();
    final errno = await _post(url, req, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    return NetRsp(true, data: json['code'] == 1);
  }

  // 发送 Post 请求, 没有错误则返回 null, 并将数据填充到 json 这个 map 中
  // 若有错误则返回错误信息
  Future<String> _post(
      String url, dynamic data, Map<String, dynamic> json) async {
    try {
      Response response = await dio.post(url, data: data);
      Map<String, dynamic> res = response.data;
      int code = res['code'];
      if (code == 1) {
        json.addAll(res);
        return null;
      } else {
        String msg = res['msg'] != null ? res['msg'] : "";
        Logger.d(_TAG, msg);
        if ((msg == StringConstant.jwtExpired ||
                msg == StringConstant.jwtMalformed) &&
            tokenErrCallback != null) {
          tokenErrCallback();
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

  // 发送 Get 请求, 没有错误则返回 null, 并将结果填充到 json 这个 map 中
  // 若有错误则返回错误信息
  Future<String> _get(String url, Map<String, dynamic> json) async {
    try {
      Response response = await dio.get(url);
      Map<String, dynamic> res = response.data;
      int code = res['code'];
      if (code == 1) {
        json.addAll(res);
        return null;
      } else {
        String msg = res['msg'] != null ? res['msg'] : "";
        Logger.d(_TAG, msg);
        if ((msg == StringConstant.jwtExpired ||
                msg == StringConstant.jwtMalformed) &&
            tokenErrCallback != null) {
          tokenErrCallback();
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

  factory Server() => _getInstance();

  static Server get instance => _getInstance();

  Server._internal() {
    Logger.i(_TAG, 'initialized');
  }

  static Server _instance;

  static Server _getInstance() {
    if (_instance == null) {
      _instance = Server._internal();
    }
    return _instance;
  }
}

class _LoggingInterceptors extends Interceptor {
  static const _TAG = "LoggingInterceptors";

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    Logger.d(_TAG,
        "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    Logger.d(_TAG, "Headers:");
    options.headers.forEach((k, v) => Logger.d(_TAG, '$k: $v'));
    if (options.queryParameters != null) {
      Logger.d(_TAG, "queryParameters:");
      options.queryParameters.forEach((k, v) => Logger.d(_TAG, '$k: $v'));
    }
    if (options.data != null) {
      Logger.d(_TAG, "Body: ${options.data}");
    }
    Logger.d(_TAG,
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    return options;
  }

  @override
  Future<dynamic> onError(DioError dioError) async {
    Logger.d(_TAG,
        "<-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
    Logger.d(_TAG,
        "${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
    Logger.d(_TAG, "<-- End error");
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    Logger.d(_TAG,
        "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    Logger.d(_TAG, "Headers:");
    response.headers?.forEach((k, v) => Logger.d(_TAG, '$k: $v'));
    Logger.d(_TAG, "Response: ${response.data}");
    Logger.d(_TAG, "<-- END HTTP");
  }
}
