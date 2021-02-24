

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vo247_ios/ui/home/HomeScreen.dart';


class AppNavigation{

  static back(BuildContext context, {Map<String, dynamic > onDataActivityResult}){
    Navigator.of(context).pop(onDataActivityResult);

  }

  static backMultiStack(BuildContext context, int turns){
    for(int i = 0; i<turns; i++){
      Navigator.of(context).pop();
    }
  }
  static toHomeReplacement({@required BuildContext context}){
    Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.rightToLeft,
            settings: RouteSettings(name: "HomeScreen"),
            child: HomeScreen()));
  }

  static toHome({@required BuildContext context}){
    Navigator.push(
        context,
        PageTransition(type: PageTransitionType.rightToLeft,
            settings: RouteSettings(name: "HomeScreen"),
            child: HomeScreen()));
  }
}