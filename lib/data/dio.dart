import 'dart:async';

import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:UniqueBBSFlutter/tool/logger.dart';
import 'package:dio/dio.dart';

const _baseUrl = 'https://hustunique.com:7010/api';
Dio dio = Dio(BaseOptions(baseUrl: _baseUrl))
  ..interceptors.add(_LoggingInterceptors());

class NetRsp<T> {
  bool success;
  String msg;
  T data;

  NetRsp(this.success, {this.msg, this.data});
}

class Server {
  static const TAG = "Server";
  static const LoginUrl = '/user/login/pwd';

  static Future<NetRsp<void>> login(String nickname, String password) async {
    final data = {
      'nickname': nickname,
      'pwd': generateMD5(password),
    };
    try {
      Response response = await dio.post(LoginUrl, data: data);
      Logger.d(TAG, response.data);
    } catch (e) {
      Logger.d(TAG, e);
    }
  }

  static Future<Response> sendPost(String url, dynamic data) async {
    try {
      Response response = await dio.post(url, data: data);
      Logger.d(TAG, response.data);
    } catch (e) {
      // redirect to home
      Logger.d(TAG, e);
    }
  }
}

class _LoggingInterceptors extends Interceptor {
  // ignore: non_constant_identifier_names
  static final TAG = "LoggingInterceptors";

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    Logger.d(TAG,
        "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    Logger.d(TAG, "Headers:");
    options.headers.forEach((k, v) => Logger.d(TAG, '$k: $v'));
    if (options.queryParameters != null) {
      Logger.d(TAG, "queryParameters:");
      options.queryParameters.forEach((k, v) => Logger.d(TAG, '$k: $v'));
    }
    if (options.data != null) {
      Logger.d(TAG, "Body: ${options.data}");
    }
    Logger.d(TAG,
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    return options;
  }

  @override
  Future<dynamic> onError(DioError dioError) async {
    Logger.d(TAG,
        "<-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
    Logger.d(TAG,
        "${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
    Logger.d(TAG, "<-- End error");
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    Logger.d(TAG,
        "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    Logger.d(TAG, "Headers:");
    response.headers?.forEach((k, v) => Logger.d(TAG, '$k: $v'));
    Logger.d(TAG, "Response: ${response.data}");
    Logger.d(TAG, "<-- END HTTP");
  }
}
