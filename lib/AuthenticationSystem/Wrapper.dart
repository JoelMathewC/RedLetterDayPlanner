import 'package:flutter/material.dart';
import 'package:redletterday_planner/AuthenticationSystem/Auth.dart';
import 'package:redletterday_planner/Screens/Home.dart';
import 'package:redletterday_planner/Screens/SignIn.dart';
import 'package:redletterday_planner/Screens/SignUp.dart';

class Wrapper extends StatefulWidget {
  static String id = 'Wrapper';
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  bool hasAccount = true;

  void toggleView(){
    setState(() => hasAccount = !hasAccount);
  }
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthServices().user,
      builder: (context, user){
        if(user.hasData) {
          return Home();
        }
        else {
          if(hasAccount)
            return SignIn(toggleView: toggleView);
          else
            return SignUp(toggleView: toggleView);
        }
      },
    );
  }
}

