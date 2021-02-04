import 'package:flutter/material.dart';
import 'package:redletterday_planner/AuthenticationSystem/Auth.dart';

class Home extends StatefulWidget {
  static String id = 'Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

    );
  }
}


// Container(
// color: Colors.red,
// child: GestureDetector(
// onTap: () async {
// await AuthServices().signOut();
// },
// child: Container(
// color: Colors.blue,
// ),
// ),
// );