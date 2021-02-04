import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin<Sidebar>{
  AnimationController _animationController;
  final _animationDuration = Duration(microseconds: 500);

  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedStreamSink;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedStreamSink = isSidebarOpenedStreamController.sink;
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedStreamSink.close();
    super.dispose();
  }

  void onIconPressed(){
    final _animationStatus = _animationController.status;
    final isAnimationCompleted = _animationStatus == AnimationStatus.completed;

    if(isAnimationCompleted){
      isSidebarOpenedStreamSink.add(false);
      _animationController.reverse();
    }else{
      isSidebarOpenedStreamSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context,isSidebarOpenedAsync){
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0, //Start from the top
          bottom: 0, //end at the bottom
          left: isSidebarOpenedAsync.data ? 0 : -(screenWidth - 50) + 10,  // 0 or -(width - 50)
          right: isSidebarOpenedAsync.data ? 0 : screenWidth - 60,// 0 or width + 50
          child: Row(
            children: <Widget>[
              Container(
                color: Theme.of(context).accentColor,
                height: screenHeight,
                width: screenWidth - 50,
              ),
              GestureDetector(
                onTap: (){
                  onIconPressed();
                },
                child: Align(
                  alignment: Alignment(0,-0.9),
                  child:ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      color: Theme.of(context).accentColor,
                      height: 100,
                      width: 35,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}


class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

      Paint paint = Paint();
      paint.color = Colors.white;

      final width = size.width;
      final height = size.height;

      Path path = Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(0, 8, 10, 16);
      path.quadraticBezierTo(width - 1, height/2 - 20, width, height/2);
      path.quadraticBezierTo(width + 1, height/2 + 20, 10, height - 16);
      path.quadraticBezierTo(0, height - 8, 0 , height);
      path.close();

      return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}