import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vo247_ios/res/colors.dart';
import 'package:vo247_ios/ui/home/HomeScreen.dart';

import 'services/storage/AppPreferences.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
// The following two lines set the android status bar to be transparent immersive. Written after component rendering, in order to assign a value after rendering, override the status bar, the MaterialApp component will override this value before rendering.
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget{
  final Init init = Init();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "M247",
      theme: ThemeData(
        backgroundColor:  Colors.blueGrey,
        primarySwatch: Colors.grey,
      ),
      home: FutureBuilder<Init>(
        future: init.setInit(),
        builder: (context, snapshot) => (snapshot.hasData)?HomeScreen():_splashScreen(),
      ),
    );
  }

  Widget _splashScreen(){
    return Material(
      child: Align(alignment: Alignment.center,
        child: Image.asset("images/bg_splash.svg", fit: BoxFit.cover, scale: 1.0,
          width: double.infinity,
          height: double.infinity,),
      ),
    );
  }

}


class Init {
  Future<Init> setInit()async{
    /* await ...*/
    await AppPreferences().init();
    /* await ...*/
    return Init();
  }
}
