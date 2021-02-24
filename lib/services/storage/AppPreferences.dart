import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vo247_ios/utils/AppEncryption.dart';

enum AppPrefKeySTR{
  USERNAME, PHONE
}
enum AppPrefKeyINT{
  COUNT
}

class AppPreferences {
  SharedPreferences _sharedPreferences;
  static AppPreferences _instance;
  AppEncryption _encryption = new AppEncryption() ;
  AppPreferences._internal();
  factory AppPreferences(){
    _instance = _instance ?? new AppPreferences._internal();
    return _instance;
  }

  init() async {
    _sharedPreferences = _sharedPreferences ?? await SharedPreferences.getInstance();
    return _sharedPreferences;
  }

  String get defaultString => "*";
  saveString({@required AppPrefKeySTR key, @required String str, bool isEncode=false}) {

    _sharedPreferences.setString(key.toString(), (!isEncode)?str:_encryption.encrypt(str));
  }
  String getString({@required AppPrefKeySTR key,  bool isEncode=false}) {
    String str = _sharedPreferences.getString(key.toString());
    if(str == null){
      return defaultString;
    }else{
      return (!isEncode)?str:_encryption.decrypt(str);
    }
  }

  int get defaultInt => -3498;
  saveInt({@required AppPrefKeyINT key, @required int numb}) {
    _sharedPreferences.setInt(key.toString(), numb);
  }
  int getInt({@required AppPrefKeyINT key}) {
    return _sharedPreferences.getInt(key.toString())??defaultInt;
  }
}

