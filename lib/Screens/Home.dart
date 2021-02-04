import 'package:flutter/material.dart';
import 'package:redletterday_planner/AuthenticationSystem/Auth.dart';
import 'package:redletterday_planner/Screens/AddEventPage.dart';
import 'package:redletterday_planner/Sidebar/NavigationBloc.dart';

class Home extends StatefulWidget with NavigationStates{
  static String id = 'Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenHeight - 100,),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, AddEventPage.id);
                },
                child: Container(
                  width: screenWidth - 100,
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add_circle_outline,
                        color: Theme.of(context).primaryColor,),
                        SizedBox(width: 10.0,),
                        Text(
                          'Add to Calendar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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