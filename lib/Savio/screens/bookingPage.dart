import 'package:flutter/material.dart';
import 'package:tables24_v3/Savio/widgets/showTables.dart';


class BookingPage extends StatefulWidget {
  String resName;
  String resId;
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  String _chosenValue = 'one';
  Map<String, String> requirements = {};

  BookingPage(String this.resName, String this.resId){
    requirements['date'] = this._dateTime.toString().substring(0, 10);
    requirements['time'] = this._timeOfDay.toString().substring(10, 15);
    requirements['noOfSeats'] = this._chosenValue;
  }

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50.0,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Pick a date'),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2222))
                            .then((date) {
                          setState(() {
                            widget._dateTime = date;
                            widget.requirements['date'] = date.toString().substring(0, 10);
                          });
                        });
                      },
                    ),
                    Text(widget._dateTime == null
                        ? 'Nothing has been picked yet'
                        : widget._dateTime.toString().substring(0, 10)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Pick a time'),
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((time) {
                          setState(() {
                            widget._timeOfDay = time;
                            widget.requirements['time'] = time.toString().substring(10, 15);
                          });
                        });
                      },
                    ),
                    Text(widget._timeOfDay == null
                        ? 'Nothing has been picked yet'
                        : widget._timeOfDay.toString().substring(10, 15)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    DropdownButton<String>(
                      value: widget._chosenValue,
                      items: <String>['one', 'two', 'Three', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          widget._chosenValue = value;
                        });
                      },
                    ),
                    Text("no of seats"),
                  ],
                ),
              ]),

          Container(height: 500, width: 400,child: ShowTables(widget.requirements)),
        ],
      ),
    ));
  }
}