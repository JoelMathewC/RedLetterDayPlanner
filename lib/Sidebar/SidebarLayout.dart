import 'package:flutter/material.dart';
import 'package:redletterday_planner/Screens/Home.dart';
import 'package:redletterday_planner/Sidebar/NavigationBloc.dart';
import 'package:redletterday_planner/Sidebar/Sidebar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SidebarLayout extends StatelessWidget {
  static String id = 'SidebarLayout';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(Home()),
        child:Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc,NavigationStates>(
              builder: (context, navigationState){
                return navigationState as Widget;
              }
            ),
            Sidebar(name: 'Joel Mathew'),
          ],
        ),
      )
    );
  }
}
