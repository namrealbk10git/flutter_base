import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppPushNotificationsManager {
  AppPushNotificationsManager._();

  factory AppPushNotificationsManager() => _instance;

  static final AppPushNotificationsManager _instance =
  AppPushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  String _fcmToken ;
  String get fcmToken => _fcmToken??"";
  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (message) async {
          var notification = message["notification"];
          String title =  notification["title"];
          String des =  notification["body"];
          var data = message['data'] ;
          _showNotification(
            title: title,
            des: des,
            data: null,
          );
        },
        onResume: (message) async {
          var notification = message["notification"];
          String title =  notification["title"];
          String des =  notification["body"];
          var data = message['data'] ;
          _showNotification(
            title: title,
            des: des,
            data: null,
          );
        },
        onLaunch: (message) async {
          var notification = message["notification"];
          String title =  notification["title"];
          String des =  notification["body"];
          var data = message['data'] ;
          _showNotification(
            title: title,
            des: des,
            data: null,
          );
        },
        // onBackgroundMessage: (message) async {
        // var notification = message["notification"];
        // String title =  notification["title"];
        // String des =  notification["body"];
        // var data = message['data'] ;
        // _showNotification(
        //   title: title,
        //   des: des,
        //   data: null,
        // );
        // },
      );

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      _fcmToken = token;
      print("token fcm :" + token);
      _initialized = true;
      initializing();
    }
  }
  void _showNotification({String title, String des,  Map<String, dynamic> data}) async{
    await notification(title: title, des: des);

  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;
  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );
    initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }
    // we can set navigator to navigate another screen
    return null;
  }

  Future<void> notification({String title, String des}) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'Channel ID', 'Channel title', 'channel body',
        priority: Priority.high,
        importance: Importance.max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
      // sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true
    );

    NotificationDetails notificationDetails =
    NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, des, notificationDetails);
  }


}