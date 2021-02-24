import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vo247_ios/res/colors.dart';
import 'package:vo247_ios/utils/ConnectionStatus.dart';
import 'package:vo247_ios/view/AppDelegate.dart';
import 'package:vo247_ios/view/AppViewLoading.dart';


abstract class AppBaseViewState extends State implements AppDelegate{
   StreamController streamLoading;
   StreamController streamIsOnline;

  StreamSubscription _connectionChangeStream;

  @override
  void initState() {
    super.initState();
    _connectionChangeStream = ConnectionStatus()
        .connectionChange
        .listen((event) => connectionChanged(event));
    streamIsOnline = new StreamController<bool>.broadcast();
    streamLoading = new StreamController<bool>.broadcast();
  }

  void connectionChanged(dynamic hasConnection) {
    if (hasConnection) {
      // do somethings
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    streamLoading?.close();
    streamIsOnline?.close();
    _connectionChangeStream?.cancel();
  }



  @mustCallSuper
  Widget setAppBar(){
     return null;
  }
   @mustCallSuper
  Widget setFloatingActionButton(){
     return null;
   }

  @protected
  Widget setChild();

  void _setShowLoading(bool event){
     streamLoading?.add(event);
  }
  void _setIsOnline(bool event){
   streamIsOnline?.add(event);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: setAppBar(),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(child: SvgPicture.asset(
                "images/bg_main.svg",
                height: double.infinity,
                width: double.infinity,

              ),),
              StreamBuilder<bool>(
                  stream: streamIsOnline?.stream,
                  builder: (context, snapshot) {
                    return(snapshot?.data??true)?setChild() : _viewNotConnectWifi();
                  }),
              StreamBuilder<bool>(
                  stream: streamLoading?.stream,
                  builder: (context, snapshot) {
                    return(snapshot?.data??false)?Container(
                      alignment: Alignment.center,
                      color: AppColor.bgLoading,
                      child: InkWell(
                        onDoubleTap:()=> streamLoading?.add(false),
                        child: AppViewLoading(),
                      ),
                    ):SizedBox();
                  }),
            ],
          ),
        ),
        floatingActionButton: setFloatingActionButton(),
      ),
    );
  }


  Widget _viewNotConnectWifi() {
    return Container(
      child: Text("Not Connect Internet"),
    );
  }

  @override
  void onSetOnline(bool isOnline) {
    _setIsOnline(isOnline);
  }

  @override
  void onShowLoading(bool isShow) {
    _setShowLoading(isShow);
  }
}
