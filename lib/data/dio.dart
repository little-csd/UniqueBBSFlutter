import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:UniqueBBSFlutter/tool/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bean/user.dart';
import 'repo.dart';

const _baseUrl = 'https://hustunique.com:7010';
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

typedef AppInitCallback = void Function(bool, String);

class Server {
  static const _TAG = "Server";
  static const LoginUrl = '/api/user/login/pwd';
  static const UserUrl = '/api/user/info';

  static const NetworkError = '网络错误!';
  static const UidError = '找不到用户信息!';
  static const TokenExpired = 'Token 已过期!';
  static const EmptyMsg = '收到空消息!';
  static const UnknownError = '未知异常';
  static const NoError = '';

  static const UidKeyInSp = 'uid';
  static const TokenKeyInSp = 'token';

  VoidCallback tokenErrCallback;

  void init(AppInitCallback callback, VoidCallback tokenErrCallback) async {
    // token 过期统一在 _get 和 _post 方法中处理
    this.tokenErrCallback = tokenErrCallback;
    final sp = await SharedPreferences.getInstance();
    final uid = sp.getString(UidKeyInSp);
    final token = sp.getString(TokenKeyInSp);
    Logger.d(_TAG, 'token = $token, uid = $uid');
    if (uid == null || token == null) {
      callback(false, UidError);
      return;
    }
    dio.options.headers[HttpHeaders.authorizationHeader] = token;
    Repo.instance.uid = uid;
    me().then((rsp) {
      if (!rsp.success) {
        callback(false, NetworkError);
        return;
      }
      Repo.instance.userModel.put(uid, rsp.data);
      callback(true, '');
    });
    return;
  }

  Future<NetRsp<String>> login(String nickname, String password) async {
    final data = {
      'nickname': nickname,
      'pwd': generateMD5(password),
    };
    Map<String, dynamic> json;
    String errno = await _post(LoginUrl, data, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    Map<String, dynamic> msg = json['msg'];
    if (msg == null) {
      return NetRsp(false, msg: EmptyMsg);
    }
    String token = json['token'], uid = json['uid'];
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

  Future<NetRsp<User>> user(String uid) async {
    final url = '$UserUrl/$uid';
    Map<String, dynamic> json;
    String errno = await _get(url, json);
    if (errno != null) {
      return NetRsp(false, msg: errno);
    }
    Map<String, dynamic> msg = json['msg'];
    if (msg == null) {
      return NetRsp(false, msg: EmptyMsg);
    }
    User user = User.fromJson(msg);
    return NetRsp(true, data: user);
  }

  Future<NetRsp<User>> me() async {
    // should not happen here
    String uid = Repo.instance.uid;
    if (uid.isEmpty) {
      return NetRsp(false, msg: UidError);
    }
    return user(uid);
  }

  // Future<NetRsp<bool>> userUpdate() async {
  //
  // }

  Future<NetRsp<Image>> avatar(String path) async {
    try {
      Response<Uint8List> response = await dio.get(path);
      final data = response.data;
      if (data == null) {
        return NetRsp(false, msg: UnknownError);
      }
      final img = Image.memory(data);
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
