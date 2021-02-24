


import 'package:flutter/material.dart';
import 'package:vo247_ios/res/dimens.dart';

class AppStyles{
  AppStyles._();

  ///// text
  static const roboto_black_h1_bold = TextStyle(
      color: Colors.black,
      fontSize: AppDimens.textNormal,
      fontWeight: FontWeight.w700,
      fontFamily: 'Roboto');

  static const roboto_black_h1_light = TextStyle(
      color: Colors.black,
      fontSize: AppDimens.textNormal,
      fontStyle: FontStyle.normal,
      fontFamily: 'Roboto');

  static const svn_gliroy_black_h1_light = TextStyle(
      color: Colors.black,
      fontSize: AppDimens.textNormal,
      fontFamily: 'SvnGliroy');

  static const svn_gliroy_black_h1_bold = TextStyle(
      color: Colors.black,
      fontSize: AppDimens.textNormal,
      fontWeight: FontWeight.w700,
      fontFamily: 'SvnGliroy');

}