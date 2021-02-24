

import 'package:vo247_ios/ui/home/HomeDelegate.dart';

class HomeBloc{
   static HomeBloc _instance;
   HomeBloc._internal();
   factory HomeBloc(){
    return _instance?? new HomeBloc._internal();
  }

  HomeDelegate _delegate;
   void setDelegate(HomeDelegate delegate){
     this._delegate = delegate;
   }

   void onClick(){
     _delegate.onShowLoading(true);
   }

}