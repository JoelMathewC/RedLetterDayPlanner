import 'package:flutter/material.dart';
import 'package:redletterday_planner/Screens/Home.dart';
import 'package:redletterday_planner/Sidebar/Sidebar.dart';


class SidebarLayout extends StatelessWidget {
  static String id = 'SidebarLayout';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Home(),
          Sidebar(),
        ],
      ),
    );
  }
}
