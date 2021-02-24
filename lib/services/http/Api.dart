import 'dart:core';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:vo247_ios/AppConfig.dart';
import 'package:vo247_ios/models/login/LoginReq.dart';
import 'package:vo247_ios/models/login/LoginRes.dart';
import 'package:vo247_ios/services/http/GeneralDataApi.dart';

@RestApi(baseUrl: AppConfig.BASE_URL)
class Api {
  static Api instance;

  factory Api(Dio dio, {String baseUrl}) {
    if (instance == null) {
      instance = new Api._internal(dio);
      ArgumentError.checkNotNull(dio, '_dio');
      instance.baseUrl = baseUrl ??= '';
    }
    return instance;
  }

  Api._internal(this._dio);
  final Dio _dio;
  String baseUrl;
////////////////////////////////////////////////////////////////// LOGIN ////////////////
  Future<GeneralDataApi<LoginRes>> login(LoginReq body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = body.toJson();
    final _result = await _dio.request<Map<String, dynamic>>(
        '/user/login-phone',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GeneralDataApi<LoginRes>.fromJson(
      _result.data,
    );
    return value;
  }
  //////////////////////////////////////////////////////////////////////////// ...... ////
}
