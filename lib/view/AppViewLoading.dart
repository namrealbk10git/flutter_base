import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vo247_ios/res/colors.dart';

const _defaultSpeed = Duration(milliseconds: 500);

class AppViewLoading extends StatefulWidget {
  final Duration speed;
  final Color primaryColor;
  final Color secondaryColor;
  final double size;

  AppViewLoading(
      {this.speed = _defaultSpeed,
        this.primaryColor = AppColor.bgColor,
        this.secondaryColor = AppColor.bgItemColor,
        this.size = 6});

  @override
  _CustomDotLoadingState createState() => _CustomDotLoadingState();
}

class _CustomDotLoadingState extends State<AppViewLoading> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  StreamController animationValueStreamController = StreamController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _animationController.repeat(period: widget.speed, reverse: true);
    _animationController.addListener(() {
      animationValueStreamController.sink.add(_animationController.value);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    animationValueStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: animationValueStreamController.stream,
        builder: (context, snapshot) {
          double value = snapshot.data ?? 0;
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: widget.size,
                  backgroundColor: value < 0.3 ? widget.primaryColor : widget.secondaryColor,
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: widget.size,
                  backgroundColor: value > 0.3 && value < 0.7 ? widget.primaryColor : widget.secondaryColor,
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: widget.size,
                  backgroundColor: value > 0.7 ? widget.primaryColor : widget.secondaryColor,
                ),
              ],
            ),
          );
        });
  }
}

