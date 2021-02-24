

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
class AppFirebaseCrashlytics {
  AppFirebaseCrashlytics._();

  factory AppFirebaseCrashlytics() => _instance;

  static final AppFirebaseCrashlytics _instance = AppFirebaseCrashlytics._();
  bool isInit = false;
  void setInitCrashlytics()async{
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    isInit = true;
  }

  void recordError(dynamic exception, {StackTrace stack , String keyReason}){
    if(!isInit){
      setInitCrashlytics();
    }
    FirebaseCrashlytics.instance.recordError(exception, stack, reason: keyReason);
    int x = 10;
  }
}