import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:redletterday_planner/AuthenticationSystem/Wrapper.dart';
import 'package:redletterday_planner/Screens/AddEventPage.dart';
import 'package:redletterday_planner/Screens/Home.dart';
import 'package:redletterday_planner/Screens/Loading.dart';
import 'package:redletterday_planner/Sidebar/SidebarLayout.dart';






void main() => runApp(App());

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState((){
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed


    if (_error) {

      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xff4DD172),
                title: Text('Something went wrong'),
                brightness: Brightness.dark,
              ),
              body: Center(
                child: Text('Are you connected to the Network?'),
              )));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {

      return Loading();
    }



    return MaterialApp(
      initialRoute: Wrapper.id,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        accentColor: Color(0xFF262AAA),
        primaryColor: Colors.white,

      ),
      routes: {
        Wrapper.id: (context) => Wrapper(),
        Home.id: (context) => Home(),
        SidebarLayout.id: (context) => SidebarLayout(),
        AddEventPage.id: (context) => AddEventPage(),
      },
    );
  }
}
