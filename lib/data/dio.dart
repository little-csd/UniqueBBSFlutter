import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui';

import 'package:UniqueBBSFlutter/data/bean/forum/basic_forum.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/full_forum.dart';
import 'package:UniqueBBSFlutter/data/bean/group/group.dart';
import 'package:UniqueBBSFlutter/data/bean/group/group_users.dart';
import 'package:UniqueBBSFlutter/data/bean/user/mentee.dart';
import 'package:UniqueBBSFlutter/data/bean/user/mentor.dart';
import 'package:UniqueBBSFlutter/data/converter.dart';
import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:UniqueBBSFlutter/tool/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bean/forum/posts.dart';
import 'bean/forum/threads.dart';
import 'bean/group/group_info.dart';
import 'bean/report/reports.dart';
import 'bean/user/user.dart';
import 'bean/user/user_info.dart';
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

/// token 错误返回信息： {code: -1, msg: jwt malformed}
class Server {
  static const _TAG = "Server";
  static const LoginUrl = '/user/login/pwd';

  static const UserUrl = '/user/info';
  static const MentorUrl = '/user/mentor/info';
  static const MyMentor = '/user/mentor/my';
  static const MyMentee = '/user/mentor/students';
  static const UpdateUser = '/user/update/normal';
  static const UpdatePwd = '/user/update/pwd';

  static const UserThread = '/user/threads';
  static const UserPost = '/user/posts';

  static const ForumList = '/forum/list';
  static const MiniForumList = '/forum/listSimple';

  static const GroupList = '/group/list';
  static const GroupUserList = '/group/users';
  static const UserGroupInfo = '/group/user';

  static const CanPostReport = '/report/can';
  static const ReportInfo = '/report/info';
  static const ReportList = '/report/list';
  static const ReportCreate = '/report/create';
  static const ReportUpdate = '/report/update';

  static const NetworkError = '网络错误!';
  static const UidError = '找不到用户信息!';
  static const TokenExpired = 'Token 已过期!';
  static const EmptyMsg = '收到空消息!';
  static const UnknownError = '未知异常';
  static const NoError = '';

  static const UidKeyInSp = 'uid';
  static const TokenKeyInSp = 'token';

  VoidCallback tokenErrCallback;

  Future<String> init(VoidCallback tokenErrCallback) async {
    // token 过期统一在 _get 和 _post 方法中处理
    this.tokenErrCallback = tokenErrCallback;
    final sp = await SharedPreferences.getInstance();
    final uid = sp.getString(UidKeyInSp);
    final token = sp.getString(TokenKeyInSp);
    Logger.d(_TAG, 'token = $token, uid = $uid');
    if (uid == null || token == null) {
      return UidError;
    }
    dio.options.headers[HttpHeaders.authorizationHeader] = token;
    Repo.instance.uid = uid;
    return NoError;
  }

  Future<NetRsp<String>> login(String nickname, String password) async {
    final data = {
      'nickname': nickname,
      'pwd': generateMD5(password),
    };
    Map<String, dynamic> json = HashMap();
    String errno = await _post(LoginUrl, data, json);
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
        .setString(UidKeyInSp, uid)
        .then((ok) => Logger.i(_TAG, 'save uid $uid $ok'));
    sp
        .setString(TokenKeyInSp, token)
        .then((value) => Logger.i(_TAG, 'save uid $token $value'));
    return NetRsp(true, data: NoError);
  }

  Future<NetRsp<User>> user(String uid) {
    final url = '$UserUrl/$uid';
    return process(url, User);
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
    final url = '$MentorUrl/$uid';
    return process(url, Mentor);
  }

  Future<NetRsp<Mentor>> myMentor() async {
    String uid = Repo.instance.uid;
    if (uid.isEmpty) {
      return NetRsp(false, msg: UidError);
    }
    return mentor(uid);
  }

  Future<NetRsp<Mentee>> myMentee() {
    return process(MyMentee, Mentee);
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
    Map<String, dynamic> json = HashMap();
    final errno = await _post(UpdateUser, req, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    return NetRsp(true, data: json['code'] == 1);
  }

  Future<NetRsp<bool>> updatePwd(String oldPwd, String newPwd) async {
    final req = {
      'previousPwd': generateMD5(oldPwd),
      'newPwd': generateMD5(newPwd),
    };
    Map<String, dynamic> json = HashMap();
    final errno = await _post(UpdatePwd, req, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    return NetRsp(true, data: json['code'] == 1);
  }

  Future<NetRsp<Threads>> threadsForUser(String uid, int page) {
    final url = '$UserThread/$uid/$page';
    return process(url, Threads);
  }

  Future<NetRsp<Posts>> postForUser(String uid, int page) {
    final url = '$UserPost/$uid/$page';
    return process(url, Posts);
  }

  // Future<NetRsp<Threads>> threadsForForum(String fid, int page) {
  //   final url = '$UserThread/$fid/$page';
  //   return process(url, Threads);
  // }
  //
  // Future<NetRsp<Threads>> postsForForum(String tid, int page) {
  //   final url = '$UserThread/$tid/$page';
  //   return process(url, Threads);
  // }

  Future<NetRsp<List<FullForum>>> forums() {
    return processArray(ForumList, FullForum);
  }

  Future<NetRsp<List<BasicForum>>> basicForums() {
    return processArray(MiniForumList, BasicForum);
  }

  Future<NetRsp<List<Group>>> groups() {
    return processArray(GroupList, Group);
  }

  Future<NetRsp<GroupUsers>> groupUsers(String gid) {
    final url = '$GroupUserList/$gid';
    return process(url, GroupUsers);
  }

  Future<NetRsp<List<GroupInfo>>> groupInfo(String uid) {
    final url = '$UserGroupInfo/$uid';
    return processArray(url, GroupInfo);
  }

  Future<NetRsp<List<bool>>> canReport() async {
    Map<String, dynamic> json = HashMap();
    final errno = await _get(CanPostReport, json);
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
    final url = '$ReportInfo/$rid';
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
    final url = '$ReportList/$uid/$page';
    return process(url, Reports);
  }

  Future<NetRsp<String>> createReport(bool weekly, String msg) async {
    final req = {
      'isWeeklyReport': weekly ? "1" : "0",
      'message': msg,
    };
    Map<String, dynamic> json = HashMap();
    final errno = await _post(ReportCreate, req, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    return NetRsp(true, data: json["msg"] as String);
  }

  Future<NetRsp<bool>> updateReport(String rid, String msg) async {
    final req = {
      'message': msg,
    };
    Map<String, dynamic> json = HashMap();
    final url = '$ReportUpdate/$rid';
    final errno = await _post(url, req, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    int code = json["code"];
    return NetRsp(true, data: code == 1);
  }

  Future<NetRsp<T>> process<T>(String url, Type type) async {
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

  Future<NetRsp<List<T>>> processArray<T>(String url, Type type) async {
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
        String msg = res['msg'] ? res['msg'] : "";
        Logger.d(_TAG, msg);
        return msg;
      }
    } catch (e) {
      // may be token expired or server error occurred
      String msg = e.toString();
      Logger.w(_TAG, msg);
      return NetworkError;
    }
  }

  // 发送 Post 请求, 没有错误则返回 null, 并将结果填充到 json 这个 map 中
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
        String msg = res['msg'] ? res['msg'] : "";
        Logger.d(_TAG, msg);
        return msg;
      }
    } catch (e) {
      // may be token expired or server error occurred
      String msg = e.toString();
      Logger.w(_TAG, msg);
      return NetworkError;
    }
  }

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
