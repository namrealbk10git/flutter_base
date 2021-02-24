//
//
// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:vo247_ios/AppConfig.dart';
// import 'package:vo247_ios/models/login/LoginReq.dart';
// import 'package:vo247_ios/models/login/LoginRes.dart';
// import 'package:vo247_ios/services/http/GeneralDataApi.dart';
//
// part 'TmpApi.g.dart';
// @RestApi(baseUrl: AppConfig.BASE_URL)
// abstract class TmpApi {
//   factory TmpApi(Dio dio) = _TmpApi;
//
//   @POST("/user/login-phone")
//   Future<GeneralDataApi<LoginRes>> login(@Body() LoginReq body);
// }