import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class AddEventPage extends StatefulWidget {
  static String id = 'AddEventPage';
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  final _formKey = GlobalKey<FormState>();
  bool isRange = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: Text('Add an Event',
        style: TextStyle(
          color: Colors.black,
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0,),
                SizedBox(
                  width: screenWidth - 50,
                  child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                          hintText: 'Name of the Event',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          fillColor: Color(0xE0E0E6),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor, width: 2.0)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:  Theme.of(context).accentColor, width: 2.0)
                          )
                      ),
                      validator: (val) =>
                      val.isEmpty
                          ? 'Enter a valid Email Address'
                          : null,
                      onChanged: (val) {
                      }
                  ),
                ),
                SizedBox(height: 15.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Spans Multiple Days',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0
                    ),),
                    SizedBox(width: 100,),
                    Switch(value: isRange, onChanged: (value){
                      setState(() {
                        isRange = value;
                      });
                    },
                    inactiveTrackColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).accentColor,
                    activeTrackColor: Theme.of(context).accentColor,),
                  ],
                ),
                SizedBox(height: 20.0,),
               Center(
                 child: GestureDetector(
                   onTap: () async {
                     await displayDateRangePicker(context);
                   },
                   child: Container(
                     color: Theme.of(context).accentColor,
                     width: screenWidth - 50,
                     child: Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Center(
                         child: Text(
                           'Choose a date',
                           style: TextStyle(
                             color: Theme.of(context).primaryColor,
                             fontSize: 20.0
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
               ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Start Date',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0
                      ),),
                    SizedBox(width: 100,),

                    Text(_startDate.toString().split(' ')[0],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0
                      ),),
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('End Date',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0
                      ),),
                    SizedBox(width: 100,),

                    Text(_endDate.toString().split(' ')[0],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0
                      ),),
                  ],
                ),
                SizedBox(height: 20.0,),
                SizedBox(
                  width: screenWidth - 50,
                  child: TextFormField(
                    maxLines: 5,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                          hintText: 'Notes',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          fillColor: Color(0xE0E0E6),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor, width: 2.0)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:  Theme.of(context).accentColor, width: 2.0)
                          )
                      ),
                      validator: (val) =>
                      val.isEmpty
                          ? 'Enter a valid Email Address'
                          : null,
                      onChanged: (val) {
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



