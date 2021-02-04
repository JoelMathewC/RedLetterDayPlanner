import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redletterday_planner/AuthenticationSystem/Auth.dart';
import 'package:redletterday_planner/Sidebar/NavigationBloc.dart';
import 'package:rxdart/rxdart.dart';

class Sidebar extends StatefulWidget {
  String name;
  Sidebar({this.name});
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 100,),
                    Center(
                      child: Container(
                        child: Text(widget.name + '\'s',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Text('Dashboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                    ),
                    SizedBox(height: 70,),
                    SidebarTabs(text: 'Home',screenWidth: screenWidth,unselectedIcon: Icons.home_outlined,selectedIcon: Icons.home,isSelected: true,onTap: (){
                      onIconPressed();
                      BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                    },),
                    SizedBox(height: 10.0,),
                    SidebarTabs(text: 'Marked Days',screenWidth: screenWidth,unselectedIcon: Icons.event_note_outlined,selectedIcon: Icons.event_note,isSelected: false,onTap: (){
                      onIconPressed();
                      BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.EventsPageClickedEvent);
                    },),
                    SizedBox(height: 10.0,),
                    SidebarTabs(text: 'Weekly Schedule',screenWidth: screenWidth,unselectedIcon: Icons.schedule_outlined,selectedIcon: Icons.schedule,isSelected: false,onTap: (){
                      onIconPressed();
                      BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.WeeklySchedulePageClickedEvent);
                    },),
                    SizedBox(height: screenHeight - 500,),
                    GestureDetector(
                      onTap: () async {
                        await AuthServices().signOut();
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: screenWidth - 100,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0,0,0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.logout,
                                  color: Colors.white,),
                                SizedBox(width: 20,),
                                Text("Logout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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

class SidebarTabs extends StatelessWidget {
  String text;
  double screenWidth;
  IconData selectedIcon;
  IconData unselectedIcon;
  bool isSelected;
  Function onTap;
  SidebarTabs({this.text,this.screenWidth,this.unselectedIcon,this.selectedIcon,this.isSelected,this.onTap});
  @override
  Widget build(BuildContext context) {
    return isSelected ? GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: screenWidth - 100,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Row(
              children: <Widget>[
                Icon(selectedIcon,
                  color: Theme.of(context).accentColor,),
                SizedBox(width: 20,),
                Text(text,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),)
              ],
            ),
          ),
        ),
      ),
    ) : GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: screenWidth - 100,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: Row(
              children: <Widget>[
                Icon(unselectedIcon,
                  color: Colors.white,),
                SizedBox(width: 20,),
                Text(text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


