import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vo247_ios/AppConfig.dart';

import 'Api.dart';

class ApiService {
  static ApiService _instance;

  static final _dio = Dio();
  static var _retrofit;

  static String _token = "";
  Map<String, String> get mapHeader =>Map<String, String>.from(_dio.options.headers);

  ApiService();

  static ApiService getInstance({bool postFile}) {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    _dio.options.headers["Authentication"] = "Bearer $_token";
    _dio.options.headers["Content-Type"] = "application/json";

    return _instance;
  }

  ApiService._internal() {
    // init Headers
    _instance = ApiService();
    _dio.options = BaseOptions(
        receiveTimeout: 3000,
        connectTimeout: 3000,
        contentType: "application/json");
    _dio.options.headers["Content-Type"] = "application/json";
    if (Platform.isAndroid) {
      _dio.options.headers["X-FIIN-CLIENT-OS"] = "android";
      _dio.options.headers["X-FIIN-APP-VERSION"] = AppConfig.androidVersion;
    } else {
      _dio.options.headers["X-FIIN-CLIENT-OS"] = "ios";
      _dio.options.headers["X-FIIN-APP-VERSION"] = AppConfig.iosVersion;
    }
  }

  Api getAPI() {
    _retrofit = Api(_dio, baseUrl: AppConfig.BASE_URL);
    return _retrofit;
  }

}